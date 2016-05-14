global with sharing class BLN_SeminarsCon {

  public string urlCheck{get;set;}

    public PageReference deleteAgenda() {
     String editedAgendaID = apexpages.currentpage().getparameters().get('deleteAgendaId');
       List<Agenda__c> agends=[select id,(select id from Time_Slots__r) from Agenda__c where id=:editedAgendaID];
       List<Time_Slots__c> timeSolts = new List<Time_Slots__c>();
      system.debug('IIIIIIIIIIIIIIIIII '+editedAgendaID );
       
        for(Agenda__c ag :agends){
          timeSolts.addAll(ag.Time_Slots__r);
        }
        dataBase.delete(timeSolts,false);
       dataBase.delete(agends,false);
      
         BLN_Seminars_DAO semDAO = new BLN_Seminars_DAO();
        segrigateSchedules(semDAO.allSemiorItemsList(selectedeventid));
         onchangeAct();
        return null;
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
        public Agenda__c newAgendas{get; set;}
        public LIST<Ticket__c> allAdminTickets{get; set;}
        public list<attendeesList> allAttendeesToParti{get; set;}
        global MAP<id, LIST<Participant__c>> agendaParticipants{get; set;}
        public BLN_Event__c selectedEvent {get; set;}
        public string eventStartDate{get; set;}
        public string eventEndDate{get; set;}
        
        
        public String seminarStartTime{get; set;}
        public String seminarEndTime{get; set;}
        public String selectedRoomId{get; set;}
        public String selectedTrackId{get; set;}
        public String selectedItemPoolId{get; set;}
        public LIST<String> selectedSpeakers{get; set;}
          
        public BLN_UtillDisplayLinks myticket {get;set;}
        public BLN_UtillDisplayLinks agendaComponent {get;set;}
        
        
        public LIST<Selectoption> roomsSelectOptions{get; set;}
        public LIST<Selectoption> trackSelectOptions{get; set;}
        public LIST<Selectoption> seminorItemPoolOptions{get; set;}
        public ID oldItemPool{get; set;}
        public LIST<Selectoption> participantsOptions{get; set;}
        public MAP<id, Item_Pool__c> itemPoolMap{get; set;}
         
        public BLN_Room__c newRoom{get;set;}
        public BLN_Track__c newTrack{get;set;}
        
        
       public LIST<Selectoption> groupByoptions{get; set;} 
       public string groupByoption{get; set;}  
       
        
      public BLN_SeminarsCon(){
        allSeminars = new LIST<Agenda__c>(); 
        agendaMap = new MAP<id, Agenda__c>();
        selectedEvent = new BLN_Event__c();
        
        createNewSeminarBool = FALSE;
        groupByoptions = new List<Selectoption>();
        groupByoptions.add(new Selectoption('Name','Name'));
        groupByoptions.add(new Selectoption('Room','Room'));
        groupByoptions.add(new Selectoption('Date','Date'));
        groupByoptions.add(new Selectoption('Track','Track'));
        groupByoption ='Name';
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
         }
          myticket.isEventAdmin =true;
       system.debug('XXXXXXXXXXXXXXXXX '+ myticket.isEventAdmin );
       }catch(Exception e){}
      
          gaterFields();
        
       // newAgendas = [SELECT ID, NAME, Agenda_Description__c, Agenda_Type__c, BLN_Track__c, Event__c,(SELECT ID, NAME, Agenda__c, Slot_End_date__c, Slot_Start_date__c FROM Time_Slots__r LIMIT 1) FROM Agenda__c WHERE ID =: 'a0qc0000000uXhpAAE'];
         
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
                             if(ag.Agenda_Type__c =='Event level Agenda'){
                                allSeminars.add(ag); 
                             }
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
        
                        for(Participant__c p: [SELECT ID, NAME, BLN_TKT_profile__c,BLN_TKT_profile__r.Video__c,BLN_TKT_profile__r.Work_Address__r.City__c,BLN_TKT_profile__r.Work_Address__r.State__c,BLN_TKT_profile__r.Work_Address__r.Country__c,BLN_TKT_profile__r.Company_Logo__c,BLN_TKT_profile__r.Biography__c,BLN_TKT_profile__r.Company_Website_URL__c,BLN_TKT_profile__r.FaceBookId__c,BLN_TKT_profile__r.LinkedInId__c,BLN_TKT_profile__r.Blogger__c,BLN_TKT_profile__r.TwitterId__c, BLN_TKT_profile__r.First_Name__c, BLN_TKT_profile__r.Last_Name__c, BLN_TKT_profile__r.Work_Phone__c,BLN_TKT_profile__r.id,BLN_TKT_profile__r.Email__c,BLN_TKT_profile__r.User_Pic__c,BLN_TKT_profile__r.TKT_Company__c,  Participant_Role__c, Time_Slot__c, Time_Slot__r.Agenda__c FROM Participant__c WHERE Time_Slot__r.Agenda__r.Event__c =: selectedeventid ]){
                                
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
                        
                        for(Agenda__c a: allSeminars){
                            agendaMap.put(a.id, a);
                            if(! agendaParticipants.containsKey(a.id)){
                                agendaParticipants.put(a.id, new LIST<Participant__c>());
                            }
                        } 
                              
        }
        
        
       
        
        
        public void createNewSeminar(){
            createNewSeminar(new Agenda__c());
        }
        
        public void editSeminar(){
           
         
           String editedAgendaID = apexpages.currentpage().getparameters().get('editAgendaId');
           
           if(editedAgendaID != null){
               if(agendaMap.containsKey(editedAgendaID )){
                   createNewSeminar(agendaMap.get(editedAgendaID));
               }
           } 
        }
        
        public void createNewSeminar(Agenda__c ag){
            
               newRoom = new BLN_Room__c();
                createNewSeminarBool = TRUE;
                timeslots = new Time_Slots__c();
                freeParticipants = new LIST<Participant__c>();
                seminarsRooms = new LIST<BLN_Room__c>();
                newAgendas = new Agenda__c();
                newTrack = new BLN_Track__c();
                allTracks = new LIST<BLN_Track__c>();
                selectedSpeakers = new LIST<String>();
                selectedItemPoolId = '';
                itemPoolMap = new MAP<id, Item_Pool__c>();
                
               createNewSeminarBool = TRUE;
                
              if(ag.id != null){
                newAgendas = [SELECT ID, NAME, Agenda_Description__c, Agenda_Type__c, BLN_Track__c, Event__c, (SELECT ID, NAME, Agenda__c, Slot_End_date__c, Slot_Start_date__c, Room__c FROM Time_Slots__r LIMIT 1) FROM Agenda__c WHERE ID =: ag.id];
                
                for(Time_Slots__c tl: newAgendas.Time_Slots__r){
                    timeslots =  tl;
                }
                 
                 BLN_Track__c selectedTrack = new BLN_Track__c();
                if( newAgendas.BLN_Track__c  != null){
                     selectedTrack = [SELECT ID, NAME, Event__c, (SELECT ID, NAME, Track__c FROM Item_Pools__r)  FROM BLN_Track__c WHERE id=: newAgendas.BLN_Track__c ];
                    
                     for(Item_Pool__c itp: selectedTrack.Item_Pools__r){
                         selectedItemPoolId = itp.id;
                         oldItemPool = itp.id;
                         break;
                     }
                }  
              }
              
               
                
               if(newAgendas.Event__c == null)
                 newAgendas.Event__c = selectedeventid;
                
          //Gather All Attendees LIST.......................................      
                BLN_Ticket_DAO itemTypesTicDAO = new BLN_Ticket_DAO(); 
                allAdminTickets = itemTypesTicDAO.userOrderAndTickets (' WHERE tkt_profile__c != null AND Item_Type__r.Item_Type_Number__c = \''+  BLN_Event_UtilityCon.speakerItemType()+'\' AND Event__c = \''+ selectedeventid+'\'');
                allBookedAttendees = new LIST<Participant__c>();
                allAttendeesToParti = new list<attendeesList>();
                
              // MAP<id, Time_Slots__c> timeSlotsMap = new MAP<Id, Time_Slots__c>([SELECT ID, NAME FROM Time_Slots__c WHERE Agenda__c =: newAgendas.id]);
               
                allBookedAttendees = [SELECT ID, NAME, BLN_TKT_profile__c, Participant_Role__c, Time_Slot__c FROM Participant__c WHERE Time_Slot__c IN: [SELECT ID, NAME FROM Time_Slots__c WHERE Agenda__c =: newAgendas.id] ] ;
                
                MAP<id, Participant__c> patMap = new MAP<id, Participant__c>();
                
                for(Participant__c p: allBookedAttendees){
                    patMap.put(p.BLN_TKT_profile__c, p);
                }
                     
                for(Ticket__c t: allAdminTickets){
                    
                    if(patMap.containsKey(t.tkt_profile__c)){
                         allAttendeesToParti.add(new attendeesList(TRUE, t, patMap.get(t.tkt_profile__c) ));
                    }else{
                        allAttendeesToParti.add(new attendeesList(FALSE, t, new Participant__c()  ));
                    }  
                      
                }
                
         //         
                seminarsRooms = [SELECT ID,NAME, Event__c, Room_Number__c FROM BLN_Room__c WHERE Event__c =: selectedeventid];
                 
                roomsSelectOptions = new LIST<Selectoption>();
                  
                  
                  roomsSelectOptions.add(new Selectoption('', 'Select Seminar Hall'));
                 
                  
                  for(BLN_Room__c r: seminarsRooms){
                        roomsSelectOptions.add(new Selectoption(r.Id, r.Name));
                  }
                 
                 allTracks =  [SELECT ID, NAME, Event__c FROM BLN_Track__c WHERE event__c =: selectedeventid];
                 trackSelectOptions = new LIST<Selectoption>();
                 
                 trackSelectOptions.add(new Selectoption('', 'Select Track'));
                 for(BLN_Track__c t: allTracks){
                        trackSelectOptions.add(new Selectoption(t.Id, t.Name));
                  }
                 
                 seminorItemPoolOptions = new LIST<Selectoption>();
                 
                 itemPoolMap = new MAP<id,  Item_Pool__c>([SELECT ID, NAME, Item_Pool_Name__c FROM Item_Pool__c WHERE Item_Type__r.Item_Type_Number__c ='IT-000018' AND Event__c =: selectedeventid  ]);
                 //AND Track__c = null
                 seminorItemPoolOptions.add(new Selectoption('', 'Selecte Seminar Ticket'));
                 
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
    public void saveAgenda(){
    
                         
                     if(urlCheck == 'BLN_agenda'){
                       newAgendas.Agenda_Type__c ='Track level Agenda';
                     }else{
                       newAgendas.Agenda_Type__c ='Event level Agenda';
                     }
                     
        
        Database.UpsertResult agendaRes = DataBase.upsert(newAgendas, false);
        
        
         system.debug('BBBBBBBBBBBBBBBBBBBBBBBBBBBBB        '+ eventStartDate);
         system.debug('BBBBBBBBBBBBBBBBBBBBBBBBBBBBB        '+ eventEndDate); 
        
        
        timeslots.Slot_Start_date__c = dateTime.parse(eventStartDate);
        timeslots.Slot_End_date__c = dateTime.parse(eventEndDate);
        
        timeslots.Slot_Start_date__c = timeslots.Slot_Start_date__c.addHours(-5);
        timeslots.Slot_End_date__c = timeslots.Slot_End_date__c.addHours(-5);
        
        system.debug('BBBBBBBBBBBBBBBBBBBBBBBBBBBBB        '+ eventStartDate +'      '+timeslots.Slot_Start_date__c );
        system.debug('BBBBBBBBBBBBBBBBBBBBBBBBBBBBB        '+ eventEndDate+'      '+timeslots.Slot_End_date__c); 
        
        if(timeslots.Agenda__c == null)
            timeslots.Agenda__c = agendaRes.getId();
        
        Database.UpsertResult timeSlotsRes = DataBase.upsert(timeslots, false);
        
           system.debug('CCCCCCCCCCCCCCCCCCCCCCCCCCccc        '+ timeSlotsRes);
           
           
             if(selectedItemPoolId != null && selectedItemPoolId !=''){ 
                Item_Pool__c itemPoolForUpdate = [SELECT ID, NAME, Track__c FROM Item_Pool__c WHERE ID =: selectedItemPoolId];
                itemPoolForUpdate.Track__c = newAgendas.BLN_Track__c;
                    
              databAse.Saveresult itemPoolResult = Database.update(itemPoolForUpdate);
              //If Old Values and New Values are diffarent we will delete the old Values from Item Pools. 
               system.debug(newAgendas.BLN_Track__c+'CCCCCCCCCCCCCCCCCCCCCCCCCCccc  1111111111111111111111      '+itemPoolResult+'     '+itemPoolForUpdate.Track__c);
              
               if(oldItemPool != null){
                     system.debug('CCCCCCCCCCCCCCCCCCCCCCCCCCccc  1111111111111111111111      '+ oldItemPool+'     '+selectedItemPoolId);
                    if(oldItemPool != selectedItemPoolId){
                        system.debug('CCCCCCCCCCCCCCCCCCCCCCCCCCccc  222222222222222222222222      '+ oldItemPool+'     '+selectedItemPoolId);
                        
                         Item_Pool__c itemPoolFordeleteOldValue = [SELECT ID, NAME, Track__c FROM Item_Pool__c WHERE ID =: oldItemPool];
                            itemPoolFordeleteOldValue.Track__c = null;
                                
                          databAse.Saveresult itemPooldeleteResult = Database.update(itemPoolFordeleteOldValue);
                    }
               }
       } 
       
        LIST<Participant__c> newParticipantsList = new LIST<Participant__c>();
        LIST<Participant__c> deleteParticipantsList = new LIST<Participant__c>(); 
         
        for(attendeesList a: allAttendeesToParti){
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
        }

        LIST<Database.UpsertResult> parResult = DataBase.upsert(newParticipantsList, FALSE);
        if(deleteParticipantsList.size()>0){
          dataBAse.delete(deleteParticipantsList,false);
        }
        
        system.debug('DDDDDDDDDDDDDDDDDDDDDDD        '+ parResult);
        
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
    }
    
    public void cancelAgenda(){
     createNewSeminarBool = FALSE;
   }


 public PageReference saveRoom() {
  newRoom.Event__c = selectedeventid;
          database.saveResult ref = dataBase.Insert(newRoom,false);
            if(ref.isSuccess()){
             roomsSelectOptions.add(new Selectoption(ref.getId(), newRoom.Name));
             newRoom = new BLN_Room__c();
           }
        return null;
    }


 public PageReference saveTrack() {
      system.debug('WWWWWWWWWWWWWWW CCCCCCCCCCCC'+ newTrack);
           newTrack.Event__c = selectedeventid;
           database.saveResult ref = dataBase.Insert(newTrack,false);
           if(ref.isSuccess()){
            trackSelectOptions.add(new Selectoption(ref.getId(), newTrack.Name));
             newTrack= new BLN_track__c();
           }
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
     
     if(groupByoption=='Name'){
      if(allSeminars.size()>0){
      seminarInn.add(new groupBySeminars('',allSeminars));
      }
      return null;
    }
    
     
     system.debug('YYYYYYYYYYYYYYYY '+allSeminars);
     
     
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
   
   
    
    If(groupByoption=='Room'){  
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
    }else if(groupByoption=='Date'){
        for(Date rom :listOfDates){
             List<agenda__c> agn = new List<agenda__c>();
             for(Time_Slots__c tss :ticSolts){
              if(tss.Slot_Start_date__c.date() ==rom){
                  agn.add(mapAgendaWithId.get(tss.agenda__c));
               }
            }
          seminarInn.add(new groupBySeminars(rom,agn));  
         }    
      } else if(groupByoption=='Track'){
       for(id rom :listOftrk){
         List<agenda__c> agn = new List<agenda__c>();
          for(Time_Slots__c tss :ticSolts){
            if(tss.Agenda__r.BLN_Track__c ==rom){
              agn.add(mapAgendaWithId.get(tss.agenda__c));
            }
          }
        seminarInn.add(new groupBySeminars(maptrackWithId.get(rom),agn)); 
       }  
   }      
   return null;
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

}