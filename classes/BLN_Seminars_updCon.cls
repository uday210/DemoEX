global with sharing class BLN_Seminars_updCon{

  public transient String AttName {get;set;}
  public transient String AttData {get;set;}
  public string allrolesandids{get;set;}  
  public string allSpeakrids{get;set;}
  public Boolean isMove {get;set;}
  public Date mysDate{get;set;}
   public Date myEDate{get;set;}
  //public list<spkrndrole> l_spkr_role;
  public string urlCheck{get;set;}
  public list<trackmapcls> TrckMap{get;set;}
  public list<trackmapcls> RoleMap {get;set;}
  public list<roommapcls> RrcMap{get;set;}
    public transient List<Attachment> attlist{get;set;}
    public string EditAgendaId {get;set;}
    
    public PageReference deleteAgenda() {
     String editedAgendaID = apexpages.currentpage().getparameters().get('deleteAgendaId');
       List<Agenda__c> agends=[select id,name,Agenda_Name__c,(select id from Time_Slots__r),BLN_Ticket__c from Agenda__c where id=:editedAgendaID];
       List<Time_Slots__c> timeSolts = new List<Time_Slots__c>();
       List<Participant__c> delp=new List<Participant__c>();
      system.debug(' '+editedAgendaID );
       
        for(Agenda__c ag :agends){
          timeSolts.addAll(ag.Time_Slots__r);
        }
        
        delp=[select id,name,Time_Slot__c from Participant__c where Time_Slot__c in:timeSolts];
         dataBase.delete(delp,false);
        dataBase.delete(timeSolts,false);
       dataBase.delete(agends,false);
      
      
         BLN_Seminars_DAO semDAO = new BLN_Seminars_DAO();
        segrigateSchedules(semDAO.allSemiorItemsList(selectedeventid));
         onchangeAct();
        return null;
    }


public List<selectOption> getVisibility() {
   BLN_ReUse_EventsEditCon bre = new BLN_ReUse_EventsEditCon();
       return bre.getPickValues(new Agenda__c(), 'Visibility__c', null);
    }   
   

       public LIST<Agenda__c> allSeminars{get; set;}
        public MAP<id, Agenda__c> agendaMap{get; set;}
        public id selectedeventid{get; set;}
        public Boolean createNewSeminarBool{get; set;}
        public LIST<BLN_Track__c> allTracks{get; set;}
        public Time_Slots__c timeslots{get; set;}
        public LIST<Participant__c> freeParticipants{get; set;}
        public LIST<Participant__c> allBookedAttendees{get; set;}
        public LIST<BLN_Room__c> seminarsRooms{get; set;}
        public list<BLN_Participant_Role__c > completeRoles{get;set;}
        public Agenda__c newAgendas{get; set;}
        public transient LIST<Ticket__c> allAdminTickets{get; set;}
        //public list<attendeesList> allAttendeesToParti{get; set;}
        global MAP<id, LIST<Participant__c>> agendaParticipants{get; set;}
        public BLN_Event__c selectedEvent {get; set;}
        public string eventStartDate{get; set;}
        public string eventEndDate{get; set;}
        public LIST<Participant__c> patispentspeakerslist ;
        
        public String seminarStartTime{get; set;}
        public String seminarEndTime{get; set;}
        public String selectedRoomId{get; set;}
        public String selectedTrackId{get; set;}
        public String selectedItemPoolId{get; set;}
        public LIST<String> selectedSpeakers{get; set;}
          
        public BLN_UtillDisplayLinks myticket {get;set;}
        public BLN_UtillDisplayLinks agendaComponent {get;set;}
        public LIST<Selectoption> Al_speaker{get;set;}
        public List<String> sel_speaker{get;set;}
        
        public LIST<Selectoption> roomsSelectOptions{get; set;}
        public LIST<Selectoption> trackSelectOptions{get; set;}
        public LIST<Selectoption> RoleSelectOptions{get; set;}
        public string[] selecedRolesinpick{get;set;}
        public LIST<Selectoption> seminorItemPoolOptions{get; set;}
        //public ID oldItemPool{get; set;}
        public LIST<Selectoption> participantsOptions{get; set;}
        public MAP<id, Item_Pool__c> itemPoolMap{get; set;}
         
        public BLN_Room__c newRoom{get;set;}
        public BLN_Track__c newTrack{get;set;}
        public String eventSDateTime{get;set;}
        public String eventEDateTime{get;set;}
        
        
        
       public LIST<Selectoption> groupByoptions{get; set;} 
       public string groupByoption{get; set;}  
       
       // Author Phani  this method will give time disfference between GMT and User TimeZone
       public Double offset{get{
         TimeZone tz = UserInfo.getTimeZone();
         //Milliseconds to Day
          return tz.getOffset(DateTime.now()) / (1000 * 3600 * 24.0);
       }
    }       
        
    public void DelAttachment(){
        List<Attachment> attac = new List<Attachment>();
        attac = [select Id,Name From Attachment where id=: ApexPages.currentPage().getParameters().get('deletedId') ];
        Database.DeleteResult[] DR_Dels = Database.delete(attac,True); 
        //get the attachements for clientgnuser
        attlist = new List<Attachment>();
        attlist = [SELECT Id, Name,Description,ContentType FROM Attachment where parentid=:EditAgendaId];
    }
 
      public BLN_Seminars_updCon(){
       nsprole= new List<NestedSpeakerRole>(); 
        allSeminars = new LIST<Agenda__c>(); 
        agendaMap = new MAP<id, Agenda__c>();
        selectedEvent = new BLN_Event__c();
        
        createNewSeminarBool = FALSE;
        isMove =false;
        groupByoptions = new List<Selectoption>();
        groupByoptions.add(new Selectoption('Seminargrp','Seminar'));
        groupByoptions.add(new Selectoption('Trackgrp','Track'));
        groupByoptions.add(new Selectoption('Roomgrp','Room'));
        groupByoptions.add(new Selectoption('Speakergrp','Speaker'));
        groupByoptions.add(new Selectoption('Dategrp','Date'));
         
        groupByoption ='Seminargrp';
       try{
        system.debug('  COOKIE VALUE '+ApexPages.currentPage().getCookies().get('counter'));
         Cookie k = ApexPages.currentPage().getCookies().get('counter');
         system.debug('  COOKIE VALUE '+k);
            if(k!=null){
                selectedeventid = k.getValue();
            }else{
                 
                //selectedeventid =;
            }
            
         system.debug('EVent Id  '+selectedeventid );
         
          myticket = new BLN_UtillDisplayLinks();
          urlCheck =  ApexPages.currentPage().getUrl();
                     if(urlCheck !=''){  // checking url for knowing about currentpage
                        if((urlCheck.toLowerCase()).contains('BLN_EventSchedule'.toLowerCase())){
                            urlCheck ='BLN_EventSchedule';
                        }else{
                            urlCheck ='BLN_agenda';
                        }
                    }
         
        
        
        
          if( urlCheck =='BLN_agenda'){
             myticket.isSeminorsPage= 'active';
             myticket.tablabel='Seminars';
             myticket.isSeminorsPageExpand='expand';
           
         }else{
            myticket.iseventschedulePage= 'active';
            myticket.tablabel='Event Schedule';
            myticket.isSeminorsPageExpand='expand';
            
           }
            myticket.eventId = selectedeventid ;
         myticket.userPermissions(userInfo.getUserId(),selectedeventid);
          
          
         LIST<BLN_Event__c> eventsList = new LIST<BLN_Event__c>();
         BLN_Event_DAO evDAO = new BLN_Event_DAO();
         eventsList =  evDAO.getEventDetails(selectedeventid);
         
         selectedEvent = new BLN_Event__c();
         if(eventsList.size() > 0){
          myticket.EventName =eventsList[0].Name;
                selectedEvent = eventsList[0];
              myticket.EventTimeZone=eventsList[0].Time_Zone__c;   
              eventSDateTime = eventsList[0].Start_Date__c.format('MM/dd/yyyy hh:mm a', eventsList[0].Time_Zone__c);
              eventEDateTime  = eventsList[0].End_Date__c.format('MM/dd/yyyy hh:mm a', eventsList[0].Time_Zone__c);
         }
          myticket.isEventAdmin =true;
           mysDate = date.newinstance(selectedEvent.Start_Date__c.year(), selectedEvent.Start_Date__c.month(), selectedEvent.Start_Date__c.day());
         myEDate=date.newinstance(selectedEvent.End_Date__c.year(), selectedEvent.End_Date__c.month(), selectedEvent.End_Date__c.day());
       system.debug('XXXXXXXXXXXXXXXXX '+ myticket.isEventAdmin );
       }catch(Exception e){}
      gaterFields();
        
       // newAgendas = [SELECT ID, NAME, Agenda_Description__c, Agenda_Type__c, BLN_Track__c, Event__c,(SELECT ID, NAME, Agenda__c, Slot_End_date__c, Slot_Start_date__c FROM Time_Slots__r LIMIT 1) FROM Agenda__c WHERE ID =: 'a0qc0000000uXhpAAE'];
         TrckMap =new list<trackmapcls>();
         RrcMap = new list<roommapcls>();
         RoleMap =new list<trackmapcls>();
        
       // createNewSeminar(newAgendas);
       onchangeAct();
    }
        
    //Constructor for Webservice
       
      public BLN_Seminars_updCon(string EventID){
       nsprole= new List<NestedSpeakerRole>(); 
        allSeminars = new LIST<Agenda__c>(); 
        agendaMap = new MAP<id, Agenda__c>();
        selectedEvent = new BLN_Event__c();
        
           selectedeventid = EventID;
        groupByoption ='Seminargrp';
         system.debug('EVent Id  '+selectedeventid );

         LIST<BLN_Event__c> eventsList = new LIST<BLN_Event__c>();
         BLN_Event_DAO evDAO = new BLN_Event_DAO();
         eventsList =  evDAO.getEventDetails(selectedeventid);
         

          gaterFields();
        
       // newAgendas = [SELECT ID, NAME, Agenda_Description__c, Agenda_Type__c, BLN_Track__c, Event__c,(SELECT ID, NAME, Agenda__c, Slot_End_date__c, Slot_Start_date__c FROM Time_Slots__r LIMIT 1) FROM Agenda__c WHERE ID =: 'a0qc0000000uXhpAAE'];
         TrckMap =new list<trackmapcls>();
         RrcMap = new list<roommapcls>();
         RoleMap =new list<trackmapcls>();
        
       // createNewSeminar(newAgendas);
       onchangeAct();
    }    
     
        
      public void segrigateSchedules(LIST<Agenda__c> ListOfAgends){
      allSeminars = new LIst<Agenda__c>();
          if(urlCheck == 'BLN_agenda'){
                           for(Agenda__c ag : ListOfAgends){
                             if(ag.Agenda_Type__c !='Event level Agenda'){
                                allSeminars.add(ag); 
                             }
                           }
                   
                     }else{
                     
                     for(Agenda__c ag : ListOfAgends){
                             //if(ag.Agenda_Type__c =='Event level Agenda'){
                                allSeminars.add(ag); 
                             //}
                           }
                     
                     
                     }
            
      }
        
        
      // We will call all the fields realted to agenda to display in table.
        public void gaterFields(){
                BLN_Seminars_DAO semDAO = new BLN_Seminars_DAO();
                
                LIST<Agenda__c> allSeminarsBeforeSegrigate = new  LIST<Agenda__c>();
                allSeminars = new LIST<Agenda__c>();
                  allSeminarsBeforeSegrigate  = semDAO.allSemiorItemsList(selectedeventid);
                                      
                    segrigateSchedules(allSeminarsBeforeSegrigate);                  
                                      
                   /*  if(urlCheck == 'BLN_agenda'){
                           for(Agenda__c ag : allSeminarsBeforeSegrigate  ){
                             if(ag.Agenda_Type__c !='Event level Agenda'){
                                allSeminars.add(ag); 
                             }
                           }
                   
                     }else{
                     
                     for(Agenda__c ag : allSeminarsBeforeSegrigate  ){
                             if(ag.Agenda_Type__c =='Event level Agenda'){
                                allSeminars.add(ag); 
                             }
                           }
                     
                     
                     }
                  */       
                   agendaParticipants = new MAP<id, LIST<Participant__c>> ();
                   system.debug('selectedeventid============================================'+selectedeventid);
        
                                
                        SET<Id> Ids = new SET<Id>();
                        MAP<Id, Ticket__c> objTKTMap = new MAP<Id, Ticket__c>();
                        LIST<Participant__c> objPartList = new LIST<Participant__c>();
                        LIST<Ticket__c> objTKTList = new LIST<Ticket__c>();
                        
                        objPartList = [SELECT ID, NAME, BLN_TKT_profile__c,BLN_Participant_Role__r.Name, BLN_TKT_profile__r.First_Name__c,BLN_TKT_profile__r.Email__c,BLN_TKT_profile__r.Mobile__c,BLN_TKT_profile__r.Home_Address__r.City__c,BLN_TKT_profile__r.Home_Address__r.State__c,BLN_TKT_profile__r.Home_Address__r.Country__c,BLN_TKT_profile__r.LinkedInId__c,BLN_TKT_profile__r.FaceBookId__c,BLN_TKT_profile__r.Biography__c,BLN_TKT_profile__r.Video__c,BLN_TKT_profile__r.TwitterId__c,BLN_TKT_profile__r.Blogger__c,BLN_TKT_profile__r.BLN_Company__r.Name,BLN_TKT_profile__r.BLN_Company__r.Website_URL__c,BLN_TKT_profile__r.BLN_Company__r.Company_Logo__c,BLN_TKT_profile__r.Home_Phone__c,BLN_TKT_profile__r.User_Pic__c, BLN_TKT_profile__r.Last_Name__c, BLN_TKT_profile__r.Work_Phone__c, Participant_Role__c, Time_Slot__c, Time_Slot__r.Agenda__c,Time_Slot__r.Agenda__r.Event__c FROM Participant__c WHERE Time_Slot__r.Agenda__r.Event__c =: selectedeventid ];
                        
                        for(Participant__c p: objPartList){
                            Ids.Add(p.BLN_TKT_profile__c);
                            //objPartMap.put(p.)
                        }
                        
                        if(Ids.size() > 0){
                            objTKTList = [SELECT Id, tkt_profile__c FROM Ticket__c WHERE Ticket_Status__c = 'Booked' AND  tkt_profile__c IN: Ids];
                        }
                        
                        for(Ticket__c t: objTKTList){
                            if(!objTKTMap.containsKey(t.tkt_profile__c)){
                                objTKTMap.put(t.tkt_profile__c, t);
                            }
                        }
                  
                        for(Participant__c p: objPartList){
                            if(objTKTMap.containsKey(p.BLN_TKT_profile__c)){
                                if(agendaParticipants.containsKey(p.Time_Slot__r.Agenda__c)){
                                        LIST<Participant__c> partt = new LIST<Participant__c>();
                                        partt = agendaParticipants.get(p.Time_Slot__r.Agenda__c);
                                        partt.add(p);
                                        agendaParticipants.put(p.Time_Slot__r.Agenda__c, partt);
                                }else{
                                        LIST<Participant__c> partt = new LIST<Participant__c>();
                                        partt.add(p);
                                        
                                        agendaParticipants.put(p.Time_Slot__r.Agenda__c, partt);
                                }
                        }
                        }
                        
                        for(Agenda__c a: allSeminars){
                            agendaMap.put(a.id, a);
                            if(! agendaParticipants.containsKey(a.id)){
                                agendaParticipants.put(a.id, new LIST<Participant__c>());
                            }
                        } 
                              
        }
        
        
       
        
        
        public void createNewSeminar(){
            createNewSeminar(new Agenda__c());
            sel_speaker=new List<String>();
        }
        
        public void editSeminar(){
               
         sel_speaker=new List<String>();
           String editedAgendaID = apexpages.currentpage().getparameters().get('editAgendaId');
           EditAgendaId = editedAgendaID;
           system.debug('editableseminar'+editedAgendaID);
           if(editedAgendaID != null){
               if(agendaMap.containsKey(editedAgendaID )){
                   createNewSeminar(agendaMap.get(editedAgendaID));
               }
               try{
                        attlist=[SELECT Id, Name,Description,ContentType FROM Attachment where parentid=:editedAgendaID];
                    }catch(Exception e){}
           } 
        }
        
        public void createNewSeminar(Agenda__c ag){
            allrolesandids = '';
            allSpeakrids = '';
             //l_spkr_role = new list<spkrndrole>();
               newRoom = new BLN_Room__c();
                createNewSeminarBool = TRUE;
                timeslots = new Time_Slots__c();
                freeParticipants = new LIST<Participant__c>();
                seminarsRooms = new LIST<BLN_Room__c>();
                completeRoles = new list<BLN_Participant_Role__c >();
                newAgendas = new Agenda__c();
                newTrack = new BLN_Track__c();
                allTracks = new LIST<BLN_Track__c>();
                selectedSpeakers = new LIST<String>();
                selectedItemPoolId = '';
                itemPoolMap = new MAP<id, Item_Pool__c>();
                RrcMap = new list<roommapcls>();
                RoleMap =new list<trackmapcls>();
                TrckMap = new list<trackmapcls>();
               createNewSeminarBool = TRUE;
                
              if(ag.id != null){
                newAgendas = [SELECT ID, NAME,Agenda_Name__c,BLN_Ticket__c, Agenda_Description__c, Agenda_Type__c, Video__c, Visibility__c, BLN_Track__c, Event__c, (SELECT ID, NAME, Agenda__c, Slot_End_date__c, Slot_Start_date__c, Room__c FROM Time_Slots__r LIMIT 1) FROM Agenda__c WHERE ID =: ag.id];
                
                for(Time_Slots__c tl: newAgendas.Time_Slots__r){
                    timeslots =  tl;
                    
                }
                 
                 BLN_Track__c selectedTrack = new BLN_Track__c();
                if( newAgendas.BLN_Track__c  != null){
                     selectedTrack = [SELECT ID, NAME, Event__c, (SELECT ID, NAME, Track__c FROM Item_Pools__r)  FROM BLN_Track__c WHERE id=: newAgendas.BLN_Track__c ];
                    
                    
                     }
                }  
              
             //set the ticket for that agenda
                         selectedItemPoolId = newAgendas.BLN_Ticket__c;
                         //oldItemPool = newAgendas.BLN_Ticket__c;
                      
              
                
               if(newAgendas.Event__c == null)
                 newAgendas.Event__c = selectedeventid;
                
          //Gather All Attendees LIST.......................................      
                BLN_Ticket_DAO itemTypesTicDAO = new BLN_Ticket_DAO(); 
                String orderStatus = 'Booked';
                allAdminTickets = itemTypesTicDAO.userOrderAndTickets (' WHERE Order__c != null AND Ticket_Status__c = \''+  orderStatus +'\'  AND Item_Pool__r.Item_Type__r.Item_Type_Number__c = \''+  BLN_Event_UtilityCon.speakerItemType()+'\' AND Event__c = \''+ selectedeventid+'\'');
                allBookedAttendees = new LIST<Participant__c>();
                system.debug('ListSize' + allAdminTickets.Size());
                //allAttendeesToParti = new list<attendeesList>();
                
              // MAP<id, Time_Slots__c> timeSlotsMap = new MAP<Id, Time_Slots__c>([SELECT ID, NAME FROM Time_Slots__c WHERE Agenda__c =: newAgendas.id]);
               
                allBookedAttendees = [SELECT ID, NAME, BLN_TKT_profile__c,BLN_Participant_Role__c, Participant_Role__c,(select id,name from BLN_Participant_Role__r), Time_Slot__c FROM Participant__c WHERE Time_Slot__c IN: [SELECT ID, NAME FROM Time_Slots__c WHERE Agenda__c =: newAgendas.id] ] ;
                
                MAP<id, Participant__c> patMap = new MAP<id, Participant__c>();
               
                for(Participant__c p: allBookedAttendees){
                    patMap.put(p.BLN_TKT_profile__c, p);
                    
                   sel_speaker.add(p.BLN_TKT_profile__c);
                }
                
                      Al_speaker= new LIST<Selectoption>();
                for(Ticket__c t: allAdminTickets){
                
                    
                    /*if(patMap.containsKey(t.Client_GN_User__c)){
                         allAttendeesToParti.add(new attendeesList(TRUE, t, patMap.get(t.Client_GN_User__c) ));
                    }else{
                        allAttendeesToParti.add(new attendeesList(FALSE, t, new Participant__c()  ));
                    } */ 
                    try{
                      if(!allSpeakrids.contains(t.tkt_profile__c)){
                      system.debug('speakcheck'+allSpeakrids);
                      Al_speaker.add(new Selectoption(t.tkt_profile__c, t.tkt_profile__r.First_Name__c+' '+t.tkt_profile__r.Last_Name__c));
                      allSpeakrids=allSpeakrids+t.tkt_profile__c+'-'+t.tkt_profile__r.First_Name__c+' '+t.tkt_profile__r.Last_Name__c+';' ;
                      system.debug('speakcheck'+allSpeakrids);
                      }
                      }catch(Exception e){}
                }
                
         //         
                 completeRoles=[SELECT ID,NAME,BLN_Events__c ,Participant_Name__c from BLN_Participant_Role__c where BLN_Events__c =: selectedeventid];// AND Participant_Name__c =: null ];
                 RoleSelectOptions = new LIST<Selectoption>();
                 
                  for(BLN_Participant_Role__c te: completeRoles){
                        RoleSelectOptions.add(new Selectoption(te.Name, te.Name));
                        RoleMap.add(new trackmapcls(te.Id,te.Name));
                        allrolesandids=allrolesandids+te.Id+'-'+te.Name+';' ;
                  }
                  
                  nsprole=new List<NestedSpeakerRole>();
                   for(Participant__c p: allBookedAttendees){
                   NestedSpeakerRole nsp=new NestedSpeakerRole();
                   nsp.Speaker=p.BLN_TKT_profile__c;
                   //String roleid='';
                    for(BLN_Participant_Role__c te: p.BLN_Participant_Role__r){
                        if(!allrolesandids.contains(te.Id+'-'+te.Name)){
                        RoleSelectOptions.add(new Selectoption(te.Name, te.Name));
                        RoleMap.add(new trackmapcls(te.Id,te.Name));
                        allrolesandids=allrolesandids+te.Id+'-'+te.Name+';' ;
                        }
                        //roleid=roleid+te.Id+',';
                  }
                  //if(roleid!='')
                  //roleid= roleid.substring(0, roleid.length() - 1);
                  nsp.Role=p.BLN_Participant_Role__c;
                   nsprole.add(nsp);
                   
                }
                 system.debug('@@@@'+allrolesandids);
                 
                 system.debug('@@completeRoles'+completeRoles);
               /*******************************/  
                patispentspeakerslist = [select id,BLN_TKT_profile__c,BLN_TKT_profile__r.First_Name__c, BLN_TKT_profile__r.Last_Name__c ,(select id,Name from BLN_Participant_Role__r) from Participant__c where Time_Slot__r.Agenda__r.Event__c =:selectedeventid];
                 
                 
                /******************************/ 
                seminarsRooms = [SELECT ID,NAME, Event__c, Room_Number__c FROM BLN_Room__c WHERE Event__c =: selectedeventid];
                 
                roomsSelectOptions = new LIST<Selectoption>();
                  
                  
                  roomsSelectOptions.add(new Selectoption('', 'Select Seminar Hall'));
                 
                  
                  for(BLN_Room__c r: seminarsRooms){
                   String rn=r.Room_Number__c==null?'': ' ('+r.Room_Number__c+')';
                       
                        roomsSelectOptions.add(new Selectoption(r.Id, r.Name + rn ));
                        RrcMap.add(new roommapcls(r.Id,r.Name,r.Room_Number__c));
                  }
                 
                 allTracks =  [SELECT ID, NAME, Event__c FROM BLN_Track__c WHERE event__c =: selectedeventid];
                 trackSelectOptions = new LIST<Selectoption>();
                 
                 trackSelectOptions.add(new Selectoption('', 'Select Track'));
                 for(BLN_Track__c t: allTracks){
                        trackSelectOptions.add(new Selectoption(t.Id, t.Name));
                        TrckMap.add(new trackmapcls(t.Id,t.Name));
                  }
                 
                 seminorItemPoolOptions = new LIST<Selectoption>();
                 
                 itemPoolMap = new MAP<id,  Item_Pool__c>([SELECT ID, NAME, Item_Pool_Name__c FROM Item_Pool__c WHERE Item_Type__r.Item_Type_Number__c ='IT-000018' AND Event__c =: selectedeventid  ]);
                 //AND Track__c = null
                 seminorItemPoolOptions.add(new Selectoption('', 'Select Seminar Ticket'));
                 
                 for(Item_Pool__c p: itemPoolMap.values()){
                        seminorItemPoolOptions.add(new Selectoption(p.id, p.Item_Pool_Name__c));
                 }
                 
                 BLN_Participant_DAO patDAO = new BLN_Participant_DAO();
                 freeParticipants = patDAO.freeParticipants(selectedeventid);
                 
                 
                 participantsOptions = new LIST<Selectoption>();
         
                 for(Participant__c p: freeParticipants ){
                    participantsOptions.add(new Selectoption(p.id, p.BLN_TKT_profile__r.First_Name__c+p.BLN_TKT_profile__r.Last_Name__c));
                 }
                 
            
            
            
                 
        }
// Inner Class for Showing Check Box in VF page

    private class attendeesList{
        
        public Boolean selectedBool{get; set;}
        public Ticket__c GNUser{get; set;}
        public Participant__c pat{get; set;}
        
        
        public attendeesList(Boolean b,  Ticket__c t, Participant__c p){
            GNUser =new Ticket__c();
            pat = new Participant__c();
            selectedBool = FALSE;
            
            pat = p;
            GNUser = t;
            selectedBool = b;
            
          //      p.Participant_Role__c = selectedUserRole;
            if( null == pat.BLN_TKT_profile__c){
                pat.BLN_TKT_profile__c= t.tkt_profile__c;
            }
            
        }
    
    }
    public pagereference saveAgenda(){
   
   
                         system.debug('@@vidyatracks'+newAgendas.BLN_Track__c);
                         
                     if(urlCheck == 'BLN_agenda'){
                       newAgendas.Agenda_Type__c ='Track level Agenda';
                       //update ticket in seminar
                       if(selectedItemPoolId != null && selectedItemPoolId !=''){
                        newAgendas.BLN_Ticket__c=selectedItemPoolId ;
                       }
                     }else{
                       newAgendas.Agenda_Type__c ='Event level Agenda';
                     }
                     
        
        Database.UpsertResult agendaRes = DataBase.upsert(newAgendas, false);
        try {
            if(AttData!='' && AttData!=null){ 
                Attachment a = new Attachment();
                a.parentId = agendaRes.id;
                a.name=AttName;
                a.body =EncodingUtil.base64Decode(AttData);
                a.IsPrivate = false;
                Insert a;
            }
        } catch (DMLException e){}
       // attachment.OwnerId = UserInfo.getUserId();
   // attachment.ParentId = agendaRes.id; // the record the file is attached to
    //attachment.IsPrivate = true;
        
    try {
      //insert attachment;
    } catch (DMLException e){}
         system.debug('BBBBBBBBBBBBBBBBBBBBBBBBBBBBB        '+ eventStartDate);
         system.debug('BBBBBBBBBBBBBBBBBBBBBBBBBBBBB        '+ eventEndDate); 
        
        
        //timeslots.Slot_Start_date__c = dateTime.parse(eventStartDate);
        //timeslots.Slot_End_date__c = dateTime.parse(eventEndDate);
        BLN_timeConToEvzoneCon timezonecl=new BLN_timeConToEvzoneCon();
        timeslots.Slot_Start_date__c = timezonecl.getDateBasedOnEventTimeZone(eventStartDate,selectedeventid);
        timeslots.Slot_End_date__c = timezonecl.getDateBasedOnEventTimeZone(eventEndDate,selectedeventid);
        
       // timeslots.Slot_Start_date__c = timeslots.Slot_Start_date__c.addHours(-4);
        //timeslots.Slot_End_date__c = timeslots.Slot_End_date__c.addHours(-4);
        
        system.debug('BBBBBBBBBBBBBBBBBBBBBBBBBBBBB        '+ eventStartDate +'      '+timeslots.Slot_Start_date__c );
        system.debug('BBBBBBBBBBBBBBBBBBBBBBBBBBBBB        '+ eventEndDate+'      '+timeslots.Slot_End_date__c); 
        
        if(timeslots.Agenda__c == null)
            timeslots.Agenda__c = agendaRes.getId();
        
        Database.UpsertResult timeSlotsRes = DataBase.upsert(timeslots, false);
        
           system.debug('CCCCCCCCCCCCCCCCCCCCCCCCCCccc        '+ timeSlotsRes);
           
           
             if(selectedItemPoolId != null && selectedItemPoolId !=''){ 
               system.debug('@@trks'+newAgendas.BLN_Track__c);
                Item_Pool__c itemPoolForUpdate = [SELECT ID, NAME, Track__c FROM Item_Pool__c WHERE ID =: selectedItemPoolId];
                itemPoolForUpdate.Track__c = newAgendas.BLN_Track__c;
               system.debug('@@itempool'+itemPoolForUpdate);     
              databAse.Saveresult itemPoolResult = Database.update(itemPoolForUpdate);
              //If Old Values and New Values are diffarent we will delete the old Values from Item Pools. 
               system.debug(newAgendas.BLN_Track__c+'CCCCCCCCCCCCCCCCCCCCCCCCCCccc  1111111111111111111111      '+itemPoolResult+'     '+itemPoolForUpdate.Track__c);
              
               /*if(oldItemPool != null){
                     system.debug('CCCCCCCCCCCCCCCCCCCCCCCCCCccc  1111111111111111111111      '+ oldItemPool+'     '+selectedItemPoolId);
                    if(oldItemPool != selectedItemPoolId){
                        system.debug('CCCCCCCCCCCCCCCCCCCCCCCCCCccc  222222222222222222222222      '+ oldItemPool+'     '+selectedItemPoolId);
                        
                         Item_Pool__c itemPoolFordeleteOldValue = [SELECT ID, NAME, Track__c FROM Item_Pool__c WHERE ID =: oldItemPool];
                            itemPoolFordeleteOldValue.Track__c = null;
                                
                          databAse.Saveresult itemPooldeleteResult = Database.update(itemPoolFordeleteOldValue);
                    }
               }*/
               }
       
        LIST<Participant__c> newParticipantsList = new LIST<Participant__c>();
        List<BLN_Participant_Role__c> updaterolelist=new List<BLN_Participant_Role__c>();
        LIST<Participant__c> deleteParticipantsList = new LIST<Participant__c>(); 
        deleteParticipantsList =[select id,name,Time_Slot__c from Participant__c where Time_Slot__c=:timeSlotsRes.getId()];
        dataBAse.delete(deleteParticipantsList,false);
         if(urlCheck == 'BLN_agenda'){
        if(nsprole.size()>0)
        {
           for(integer i=0;i<nsprole.size();i++)
           {
                //System.debug('Role' + nsprole[i].Role);
                //System.debug('Size' + nsprole[i].Speaker);

                Participant__c part = new Participant__c();
                part.Time_Slot__c = timeSlotsRes.getId();
                part.bln_tkt_profile__c=nsprole[i].Speaker;
                if(nsprole[i].Role != null){
                    if(nsprole[i].Role != ''){
                        part.BLN_Participant_Role__c=nsprole[i].Role;
                    }
                }
                newParticipantsList.add(part);
              //newParticipantsList.add(new Participant__c(Time_Slot__c = timeSlotsRes.getId(),bln_tkt_profile__c=nsprole[i].Speaker,BLN_Participant_Role__c=nsprole[i].Role));
              
           }
        }
        LIST<Database.UpsertResult> updateResults= DataBase.upsert(newParticipantsList, FALSE);
        
          /*for(Integer i=0;i<updateResults.size();i++){

            if (updateResults.get(i).isSuccess()){
            String[] role = nsprole[i].Role.split(',');
            system.debug('rolelist123'+nsprole[i].Role.length());
            if(nsprole[i].Role.length() !=0){
              for(integer j=0;j<role.size();j++){
              updaterolelist.add(new BLN_Participant_Role__c(id = role[j],Participant_Name__c=updateResults.get(i).getId()));}}
                system.debug('rolelist'+updaterolelist);
            }
            }
            
            LIST<Database.UpsertResult> updateResultsroles= DataBase.upsert(updaterolelist, FALSE);*/
            }
            else
            {
               /*if(nsprole.size()>0)
        {
           for(integer i=0;i<nsprole.size();i++)
           {
              String[] sp=nsprole[i].Speaker.split(',');
              for(integer j=0;j<sp.size();j++)
              newParticipantsList.add(new Participant__c(Time_Slot__c = timeSlotsRes.getId(),BLN_TKT_profile__c=sp[j]));
              
           }
        }*/
               system.debug('Selected Speaker Size' + sel_speaker.size());
              for(integer j=0;j<sel_speaker.size();j++){
                  system.debug('Test' + sel_speaker[j]);
              newParticipantsList.add(new Participant__c(Time_Slot__c = timeSlotsRes.getId(),BLN_TKT_profile__c=sel_speaker[j]));
              }
              
           if(newParticipantsList != null){
               if(newParticipantsList.Size() > 0){
                       LIST<Database.UpsertResult> updateResults= DataBase.upsert(newParticipantsList, FALSE);
               }
           }
           
            }
        // system.debug('@@allAttendeesToParti'+allAttendeesToParti);
        /***********************************/
        
       //if(l_spkr_role.size()>0){
        
        //}
        /*********************************/
        /*for(attendeesList a: allAttendeesToParti){
            if(a.selectedBool == TRUE){
                Participant__c p = new Participant__c();
                p = a.pat;
                
                if(p.Time_Slot__c == null)
                    p.Time_Slot__c = timeSlotsRes.getId();
                    newParticipantsList.add(p);
            } else{
              if(a.pat.id!=null){
              deleteParticipantsList.add(a.pat);
              }
            }  
        }*/

       /* LIST<Database.UpsertResult> parResult = DataBase.upsert(newParticipantsList, FALSE);
        if(deleteParticipantsList.size()>0){
          dataBAse.delete(deleteParticipantsList,false);
        }
        
        system.debug('DDDDDDDDDDDDDDDDDDDDDDD        '+ parResult);*/
        
        createNewSeminarBool = FALSE;
        /*
        allSeminars = new LIST<Agenda__c>();
        BLN_Seminars_DAO semDAO = new BLN_Seminars_DAO();
        allSeminars = semDAO.allSemiorItemsList(selectedeventid);
        
        for(Agenda__c a: allSeminars  ){
            agendaMap.put(a.id, a);
        } */
        gaterFields();
        onchangeAct();
        
        pagereference pg=new pagereference('/apex/'+urlCheck);
        pg.setRedirect(true);
        return pg;
       
    }
    
    public void cancelAgenda(){
    groupByoption ='Seminargrp';
     createNewSeminarBool = FALSE;
   }


 public PageReference saveRoom() {
string rmname_r = Apexpages.currentPage().getParameters().get('roomname').trim();
string rmnumb_r = Apexpages.currentPage().getParameters().get('roomnum').trim();
string rmid_r = Apexpages.currentPage().getParameters().get('xyid');

 system.debug('@@rmname_r '+rmname_r );
 system.debug('@@rmnumb_r '+rmnumb_r );
 system.debug('@@rmid_r '+rmid_r);
 system.debug('@@rmid_rLN '+rmid_r.Length());
 //&& rmnumb_r.Length() != 0
 if(rmname_r.Length() != 0  && rmid_r.Length() == 0 ){
  newRoom.Name = rmname_r ;
  newRoom.Room_Number__c = rmnumb_r ;
  newRoom.Event__c = selectedeventid;
          database.saveResult ref_r = dataBase.Insert(newRoom,false);

            if(ref_r.isSuccess()){
                           String rn=newRoom.Room_Number__c==null?'': ' ('+ newRoom.Room_Number__c +')';
                           
             roomsSelectOptions.add(new Selectoption(ref_r.getId(), newRoom.Name+rn));
             RrcMap.add(new roommapcls(ref_r.getId(), newRoom.Name,newRoom.Room_Number__c));
             newRoom = new BLN_Room__c();
           }
           }
           //&& rmnumb_r.Length() != 0
           if(rmname_r.Length() != 0  && rmid_r.Length() != 0 ){
         BLN_Room__c   newRoom_u = new BLN_Room__c();
         
         newRoom_u.Name =rmname_r ;
         newRoom_u.Room_Number__c = rmnumb_r ;
         newRoom_u.id =rmid_r;
         database.saveResult refrm1 =  Database.Update(newRoom_u, false);
         if(refrm1.isSuccess()){
         roomsSelectOptions.clear();
          roomsSelectOptions.add(new Selectoption('', 'Select Seminar Hall'));
           for(integer j=0;j<RrcMap.size();j++){
            if(RrcMap[j].rmid == refrm1.getid()){
           RrcMap.remove(j);
           RrcMap.add(new roommapcls(refrm1.getId(), newRoom_u.Name , newRoom_u.Room_Number__c));
           }
           String rn=RrcMap[j].rmnumb==null?'': ' ('+ RrcMap[j].rmnumb +')';
            roomsSelectOptions.add(new Selectoption(RrcMap[j].rmid , RrcMap[j].rmname+rn));
                           
           
           }
          
         }
           }
        return null;
    }
  
  public PageReference  deleteroom(){
  string roomrecid = Apexpages.currentPage().getParameters().get('delrmRecid');
  if(roomrecid !=null || roomrecid !=''){
  
   BLN_Room__c   newRoom_d= new BLN_Room__c();
            newRoom_d.id = roomrecid ;
            database.deleteResult refrd =  Database.Delete(newRoom_d, false);  
            if(refrd.isSuccess()){ 
              roomsSelectOptions.clear();
               roomsSelectOptions.add(new Selectoption('', 'Select Seminar Hall'));
           for(integer i=0;i<RrcMap.size();i++){
           if(RrcMap[i].rmid == roomrecid){
           //refrd.getid()){
           RrcMap.remove(i);
           i--;
                     }else{
                     String rn=RrcMap[i].rmnumb==null?'': ' ('+ RrcMap[i].rmnumb +')' ;
           roomsSelectOptions.add(new Selectoption(RrcMap[i].rmid , RrcMap[i].rmname+rn));
            }
           }
            }
  
  
  
  
  }
  system.debug('@@roomrecid'+roomrecid );
  return null;
  }


 public PageReference saveTrack() {
      system.debug('WWWWWWWWWWWWWWW CCCCCCCCCCCC'+ newTrack);
          newTrack.name = Apexpages.currentPage().getParameters().get('newtrackname');
          string trname =Apexpages.currentPage().getParameters().get('newtrackname');
           string utrckid = Apexpages.currentPage().getParameters().get('tdrecid');
           system.debug('@@name'+Apexpages.currentPage().getParameters().get('newtrackname'));
           system.debug('@@id'+Apexpages.currentPage().getParameters().get('tdrecid'));
          if( utrckid == ''){
          system.debug('@@kerry');
           newTrack.Event__c = selectedeventid;
           database.saveResult ref = dataBase.Insert(newTrack,false);
           if(ref.isSuccess()){
            trackSelectOptions.add(new Selectoption(ref.getId(), newTrack.Name));
            TrckMap.add(new trackmapcls(ref.getId(), newTrack.Name));
            
             newTrack= new BLN_track__c();
           }
           }
           if( utrckid != ''){
           system.debug('@@john');
       BLN_track__c    newTrack_u= new BLN_track__c();
            newTrack_u.id = utrckid.trim();
            newTrack_u.Name = trname ;
           database.saveResult ref1 =  Database.Update(newTrack_u, false);
           if(ref1.isSuccess()){
                trackSelectOptions.clear();
                trackSelectOptions.add(new Selectoption('', 'Select Track'));
           for(integer i=0;i<TrckMap.size();i++){
           if(TrckMap[i].tmapid == ref1.getid()){
           TrckMap.remove(i);
           TrckMap.add(new trackmapcls(ref1.getId(), newTrack_u.Name));
           }
            trackSelectOptions.add(new Selectoption(TrckMap[i].tmapid, TrckMap[i].tname));
           }
           //newTrack= new BLN_track__c();
           } 
           
           }
        return null;
    }
    public PageReference  deleteTrack(){
    string trecid = Apexpages.currentPage().getParameters().get('delRecid');
    if(trecid !=null || trecid !=''){
     BLN_track__c    newTrack_d= new BLN_track__c();
            newTrack_d.id = trecid.trim();
            database.deleteResult refd =  Database.Delete(newTrack_d, false);  
            if(refd.isSuccess()){ 
              trackSelectOptions.clear();
                trackSelectOptions.add(new Selectoption('', 'Select Track'));
           for(integer i=0;i<TrckMap.size();i++){
           if(TrckMap[i].tmapid == refd.getid()){
           TrckMap.remove(i);
           i--;
                     }else{
            trackSelectOptions.add(new Selectoption(TrckMap[i].tmapid, TrckMap[i].tname));
            }
           }
            }
    }
     return null;
    }
 /**********************Add and update roles *************************/   
    Public PageReference  ADDroleMD(){
    string role_Name = Apexpages.currentPage().getParameters().get('roleName_i');
    string role_id =  Apexpages.currentPage().getParameters().get('roleid_i');
    BLN_Participant_Role__c Attroles = New BLN_Participant_Role__c();
            if(role_Name.Length() != 0 && role_id.Length() == 0 ){
                Attroles.Name = role_Name ;
                Attroles.BLN_Events__c = selectedeventid ;
                database.saveResult ref_in = dataBase.Insert(Attroles,false);
                if(ref_in.isSuccess()){ 
                RoleSelectOptions.add(new Selectoption(Attroles.Name, Attroles.Name));
                RoleMap.add(new trackmapcls(ref_in.getId(), Attroles.Name));
                allrolesandids = allrolesandids+ref_in.getId()+'-'+Attroles.Name+';' ;
                system.debug('@@@addr'+allrolesandids );
                }
            }
            if(role_Name.Length() != 0 && role_id.Length() != 0 ){
            Attroles.Name = role_Name ;
            Attroles.id = role_id ;
            database.saveResult ref_up =  Database.Update(Attroles, false);
           if(ref_up.isSuccess()){
           RoleSelectOptions.clear();
           
           allrolesandids = '';
                    for(integer i=0;i<RoleMap.size();i++){
                           if(RoleMap[i].tmapid == ref_up.getid()){
                                   RoleMap.remove(i);
                                   RoleMap.add(new trackmapcls(ref_up.getId(), Attroles.Name));
                             }
                             RoleSelectOptions.add(new Selectoption(RoleMap[i].tname, RoleMap[i].tname));
                             allrolesandids =allrolesandids+RoleMap[i].tmapid+'-'+RoleMap[i].tname+';' ;
                       }
           system.debug('@@@@s'+allrolesandids );
           }
            }
            
    return null;
    }
/**************************Role Delete *************************/
public PageReference  roledelmd(){
string del_roleid = Apexpages.currentPage().getParameters().get('delroleid');

    if(del_roleid.Length() != 0){
     BLN_Participant_Role__c Attroles_d = New BLN_Participant_Role__c();
            Attroles_d.id = del_roleid;
            database.deleteResult ref_de =  Database.Delete(Attroles_d, false);  
            if(ref_de.isSuccess()){ 
            RoleSelectOptions.clear();
            allrolesandids = '';
            
               for(integer i=0;i<RoleMap.size();i++){
                   if(RoleMap[i].tmapid == ref_de.getid()){
                           RoleMap.remove(i);
                           system.debug('sagar');
                          
                     }else{
                    RoleSelectOptions.add(new Selectoption(RoleMap[i].tname, RoleMap[i].tname));
                    allrolesandids = allrolesandids+RoleMap[i].tmapid+'-'+RoleMap[i].tname+';' ;
                    system.debug('vidya');
                       }
               }
               system.debug('@@del'+allrolesandids);
            }
    }




return null;
}
/*************************save speakers*************************/

public Class NestedSpeakerRole
{
 public String Speaker{get;set;}
 public String Role{get;set;}
}
public List<NestedSpeakerRole> nsprole{get;set;}
public PageReference savespeakermd(){

 string sp_rec= Apexpages.currentPage().getParameters().get('str_v');
 system.debug('@@spk'+sp_rec);
 
 
    nsprole= new List<NestedSpeakerRole>(); 
    // Parse entire JSON response for event mandatory fields.
    JSONParser parser = JSON.createParser(sp_rec);
    while (parser != null && parser.nextToken() != null) {
        
                    nsprole= (List<NestedSpeakerRole>)parser.readValueAs(List<NestedSpeakerRole>.class);
                   

       } 
       
       System.debug('Nested '+nsprole);
 
 /*List<String> arr_rec=sp_rec.split('\\..');
 system.debug('@@spk'+sp_rec);
 system.debug('@@rec'+arr_rec);
 if(arr_rec.size()>0){
 //for(list<string> smste:arr_rec){
 for(integer i=0;i<arr_rec.size();i++){
String[] sarray = arr_rec[i].split('\\(',2);
system.debug('$$'+sarray);
string st_role=sarray[1].remove(')');
list<string> arrayofroles=st_role.split(',');
l_spkr_role.add(new spkrndrole(sarray[0],arrayofroles));

}
}
system.debug('@@@sse'+l_spkr_role);*/
return null;
}







global List<groupBySeminars> seminarInn{get;set;}

  public PageReference onchangeAct(){
    
    
     MAP<id,agenda__c> mapAgendaWithId = new MAP<id,agenda__c>();
     MAP<id,BLN_Room__c> mapRoomWithId = new MAP<id,BLN_Room__c>();
     
     
     LIst<Time_Slots__c> ticSolts = new List<Time_Slots__c>();
     seminarInn = new List<groupBySeminars>();
    
     //For Room Group
     SET<id> setOfRooms = new SET<id>();
     LIST<id> listOdRooms = new LIST<id>();
     
    
     //For Dates Group
     List<Date> listOfDates = new LIst<DAte>();
     SET<Date> SEtOfDates = new SET<DAte>();
     
     //For Track Group
     List<id> listOftrk = new LIst<id>();
     SET<Id> SEtOftrk = new SET<id>();
     MAP<id,string> maptrackWithId = new MAP<id,string>();
     
     
     system.debug('YYYYYYYYYYYYYYYY '+allSeminars+'WWWWWWWWWWWWWWWWW '+groupByoption);
     
     if(groupByoption=='Seminargrp'){
      if(allSeminars.size()>0){
      seminarInn.add(new groupBySeminars('',allSeminars));
      }
      return null;
    }
    
     
     system.debug('YYYYYYYYYYYYYYYY '+allSeminars);
     
      //system.debug('@@ticSolts');
      for(agenda__c agg :allSeminars ){
          mapAgendaWithId.put(agg.id,agg);
          ticSolts.add(agg.Time_Slots__r);
       
        //Getting all Tracks for groupby Track
               if(!SEtOftrk.contains(agg.BLN_Track__c)){
                   listOftrk.add(agg.BLN_Track__c); 
                   SEtOftrk.add(agg.BLN_Track__c); 
                   maptrackWithId.put(agg.BLN_Track__c,agg.BLN_Track__r.Name);
               }
             
        
          for(Time_Slots__c ts :agg.Time_Slots__r){
             mapRoomWithId.put(ts.Room__c,ts.Room__r);
             
            
             // Getting all date for groupby Date
              if(!SEtOfDates.contains(ts.Slot_Start_date__c.date())){
                  SEtOfDates.add(ts.Slot_Start_date__c.date()); 
                 listOfDates.add(ts.Slot_Start_date__c.date()); 
               }
          
           // Getting all Rooms for groupby Room
             if(!setOfRooms.contains(ts.room__c)){
                setOfRooms.add(ts.Room__c);
                listOdRooms.add(ts.Room__c);
             } 
         }
      
      }
    system.debug('YYYYYYYYYYYYYYYYYYYY '+listOdRooms );  
      
      
      SET<id> agnId = new SET<id>();
   
   
    
    If(groupByoption=='Roomgrp'){  
       for(id rom :listOdRooms){
        List<agenda__c> agn = new List<agenda__c>();
         for(Time_Slots__c tss :ticSolts){
            if(rom == tss.room__c){
               system.debug('$$$$$$$$$$$$  '+rom  +' @@@@@@@@@@@@@@@@@@@ '+tss.room__c);
               if(agnId.contains(tss.agenda__c)){
               
               }else{
                  agn.add(mapAgendaWithId.get(tss.agenda__c));
                  agnId.add(tss.agenda__c);
               }
            }
          }
         seminarInn.add(new groupBySeminars(mapRoomWithId.get(rom),agn));
       }
    }else if(groupByoption=='Dategrp'){
        for(Date rom :listOfDates){
             List<agenda__c> agn = new List<agenda__c>();
             for(Time_Slots__c tss :ticSolts){
              if(tss.Slot_Start_date__c.date() ==rom){
                  agn.add(mapAgendaWithId.get(tss.agenda__c));
               }
            }
          seminarInn.add(new groupBySeminars(rom,agn));  
         }    
      } else if(groupByoption=='Trackgrp'){
    //  system.debug('@@listOftrk'+listOftrk);
       for(id rom :listOftrk){
         List<agenda__c> agn = new List<agenda__c>();
          for(Time_Slots__c tss :ticSolts){
            if(tss.Agenda__r.BLN_Track__c ==rom){
              agn.add(mapAgendaWithId.get(tss.agenda__c));
            }
          }
        seminarInn.add(new groupBySeminars(maptrackWithId.get(rom),agn)); 
       }  
   } else if (groupByoption=='Speakergrp'){
       list<aggregateResult> totspkrs = [select BLN_TKT_profile__c eg  from Participant__c where Time_Slot__r.Agenda__r.Event__c =:selectedeventid group by BLN_TKT_profile__c];
      for(AggregateResult sobj : totspkrs){
      List<agenda__c> agn_s = new List<agenda__c>();
      Map<id,string> gnmap=new Map<id,string>();
      for(Participant__c lstofspeakers :[select id,BLN_TKT_profile__c, BLN_TKT_profile__r.First_Name__c, BLN_TKT_profile__r.Last_Name__c ,Time_Slot__r.Agenda__c from Participant__c where Time_Slot__r.Agenda__r.Event__c =: selectedeventid ]){
          if(string.valueof(sobj.get('eg'))== lstofspeakers.BLN_TKT_profile__c){
          agn_s.add(mapAgendaWithId.get(lstofspeakers.Time_Slot__r.Agenda__c ));
          gnmap.put(lstofspeakers.BLN_TKT_profile__c,lstofspeakers.BLN_TKT_profile__r.First_Name__c+' '+lstofspeakers.BLN_TKT_profile__r.Last_Name__c);
          }
      
       }
      seminarInn.add(new groupBySeminars(gnmap.get(string.valueof(sobj.get('eg'))),agn_s)); 
      }
       
   }
       
   return null;
  }



global class trackmapcls{
global id tmapid{get;set;}
Public string tname{get;set;}
public trackmapcls(id tmapide,string tnamee){
this.tmapid= tmapide;
this.tname = tnamee;
}
}
global class roommapcls{
public id rmid{get;set;}
public string rmname{get;set;}
public string rmnumb{get;set;}
public roommapcls(id rid,string rname,string rnumb){
this.rmid = rid;
this.rmname = rname;
this.rmnumb =rnumb;
}
}

global class spkrndrole{
public string spkr{get;set;}
public list<string> roles{get;set;}
public spkrndrole(string st,list<string> rls){
this.spkr = st;
this.roles = rls;
}
}


  global class groupBySeminars{
    public BLN_Room__c groupName{get;set;}
    public Date dateValue{get;set;}
    public List<agenda__c> agendaList{get;set;} 
    public string trackName{get;set;}
    
     public  groupBySeminars(BLN_Room__c gName,List<agenda__c> ag){
      agendaList = new List<agenda__c>();
      groupName =new BLN_Room__c();
      this.groupName = gName;
      this.agendaList = ag;
     }
     
     public  groupBySeminars(Date dDate,List<agenda__c> ag){
      agendaList = new List<agenda__c>();
      this.dateValue = dDate;
       this.agendaList = ag;
     }
     
     
      public  groupBySeminars(string tn,List<agenda__c> ag){
      agendaList = new List<agenda__c>();
      this.trackName= tn;
      this.agendaList = ag;
     }
     
    
  }

  @RemoteAction
  global static boolean getvalidationmethod(string startTime,string  endTime,LIST<string> sel_speaker,string seminarName){
  boolean errorflag =false;
  LIST<Participant__c> parLst= new LIST<Participant__c>();
  parLst= [select BLN_TKT_profile__c,Time_Slot__r.Slot_Start_date__c,Time_Slot__r.Slot_End_date__c,Time_Slot__c,Time_Slot__r.Agenda__r.Agenda_Name__c from Participant__c where BLN_TKT_profile__c =:sel_speaker and Time_Slot__r.Agenda__r.Agenda_Name__c!= :seminarName];
  system.debug('aaaaaa'+seminarName + 'parLst'+parLst);
  for(Participant__c p:parLst){
      system.debug('Datetime.parse(startTime).addHours(-4)'+Datetime.parse(startTime).addHours(-4)+'p.Time_Slot__r.Slot_Start_date__c'+p.Time_Slot__r.Slot_Start_date__c+'Datetime.parse(endTime)'+Datetime.parse(endTime).addHours(-4)+'p.Time_Slot__r.Slot_End_date__c'+p.Time_Slot__r.Slot_End_date__c);
     // if((Datetime.parse(startTime).addHours(-4) >= p.Time_Slot__r.Slot_Start_date__c && Datetime.parse(startTime).addHours(-4) <= p.Time_Slot__r.Slot_End_date__c) || (Datetime.parse(endTime).addHours(-4) >= p.Time_Slot__r.Slot_Start_date__c && Datetime.parse(endTime).addHours(-4) <= p.Time_Slot__r.Slot_End_date__c)){
      if((Datetime.parse(startTime) >= p.Time_Slot__r.Slot_Start_date__c && Datetime.parse(startTime) <= p.Time_Slot__r.Slot_End_date__c) || (Datetime.parse(endTime) >= p.Time_Slot__r.Slot_Start_date__c && Datetime.parse(endTime) <= p.Time_Slot__r.Slot_End_date__c)){
         
         system.debug('Datetime.parse(startTime)'+Datetime.parse(startTime)+'p.Time_Slot__r.Slot_Start_date__c'+p.Time_Slot__r.Slot_Start_date__c+'Datetime.parse(endTime)'+Datetime.parse(endTime)+'p.Time_Slot__r.Slot_End_date__c'+p.Time_Slot__r.Slot_End_date__c);
          errorflag =true;
      }
  }
  return errorflag;
  }
  
  //method for updating row order in drag and drop case by thirupathi pattipaka
    public String agendaOrder{get;set;}{agendaOrder='';}
    Public void updateAgendaOrder(){
        isMove=true;
        //System.debug('MMMMMMMMMMMMMMMM'+isMove);
        agendaOrder= Apexpages.Currentpage().getparameters().get('agendaOrder');
        //System.debug('@@@@@@'+agendaOrder);
        string[] splitted = agendaOrder.split(' ');
        List<Agenda__c> agendaList=new List<Agenda__c>();
        for(integer i=0;i<splitted.size();i++)
        {
             string[] ordersplit = splitted[i].split(',');
             //System.debug('MY IDDDDD:'+ordersplit[0]);

             Agenda__c q=new Agenda__c(id=ordersplit[0],Agenda_Display_Order__c=Integer.valueOf(ordersplit[1]));
             agendaList.add(q);
             
        }
        update agendaList;
    }

}