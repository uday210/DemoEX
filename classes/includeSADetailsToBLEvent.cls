public with sharing class includeSADetailsToBLEvent{
    
    public includeSADetailsToBLEvent(){
        
    }
    
    public Pagereference insertTicketsForEvent(String LoginUserId, String EventId){
                    
        LIST<TicketTypes__c> ExistingTicketsList= new LIST<TicketTypes__c>();
        ExistingTicketsList= [SELECT ID, TT_Name__c FROM TicketTypes__c WHERE (TT_Name__c =: 'Guest' OR TT_Name__c =: 'Attendee Staff') AND EV_id__c =: EventId];
        LIST<TicketTypes__c> InsertTicketsList= new LIST<TicketTypes__c>();
        MAP<String, TicketTypes__c> ticketsMAP=new MAP<String, TicketTypes__c>();
       
        if(ExistingTicketsList.size() >0){
            for(TicketTypes__c ticket: ExistingTicketsList){
                ticketsMAP.put(ticket.TT_Name__c, ticket);
                
            }
            if(! ticketsMAP.containsKey('Guest')){
                TicketTypes__c guestTicket= new TicketTypes__c(TT_Name__c ='Guest',TT_Amount__c=0,TT_TicketType__c='Free',EV_id__c= EventId,TT_Available__c=1, TT_Sold__c=0, OwnerId=LoginUserId,Avilable_for_Portal__c=false);
                InsertTicketsList.add(guestTicket);           
            }
            if(! ticketsMAP.containsKey('Attendee Staff')){
                TicketTypes__c attendeeStaffTicket= new TicketTypes__c(TT_Name__c ='Attendee Staff',TT_Amount__c=0,TT_TicketType__c='Free',EV_id__c= EventId,TT_Available__c=1, TT_Sold__c=0, OwnerId=LoginUserId,Avilable_for_Portal__c=false);
                InsertTicketsList.add(attendeeStaffTicket);
            }
       }else{
           
           TicketTypes__c guestTicket= new TicketTypes__c(TT_Name__c ='Guest',TT_Amount__c=0,TT_TicketType__c='Free',EV_id__c=EventId,TT_Available__c=1,TT_Sold__c=0,OwnerId=LoginUserId,Avilable_for_Portal__c=false);
           TicketTypes__c attendeeStaffTicket= new TicketTypes__c(TT_Name__c ='Attendee Staff',TT_Amount__c=0,TT_TicketType__c='Free',EV_id__c=EventId,TT_Available__c=1,TT_Sold__c=0,OwnerId=LoginUserId,Avilable_for_Portal__c=false);
           InsertTicketsList.add(guestTicket);
           InsertTicketsList.add(attendeeStaffTicket);
       }
       if(InsertTicketsList.size()>0){
           Database.Insert(InsertTicketsList, FALSE);       
       
       LIST<User> LoginUserEmail= new LIST<User>();
       LoginUserEmail= [SELECT ID, UserName FROM User WHERE ID =: LoginUserId];
       LIST<AttendeeSummary__c> AttendeesList= new LIST<AttendeeSummary__c>();
       AttendeesList=[SELECT ID, AS_Company__c, AS_Email__c, AS_LastName__c, AS_FirstName__c FROM AttendeeSummary__c WHERE AS_Email__c =: LoginUserEmail[0].UserName]; 
       system.debug('  AttendeesList::::   ' + AttendeesList);
           
       if(AttendeesList.size() >0){
           LIST<Event_Attendee_Mapping__c> EAMList= new LIST<Event_Attendee_Mapping__c>();
           EAMList= [SELECT ID, GuestType__c, IsCancelled__c FROM Event_Attendee_Mapping__c WHERE EV_id__c=: EventId AND AS_id__c=: AttendeesList[0].Id];            
           Event_Attendee_Mapping__c insertEAM= new Event_Attendee_Mapping__c();            
           if(EAMList.size() >0){
               EAMList[0].GuestType__c= 'Event Admin';
               EAMList[0].IsCancelled__c= FALSE;
               Database.Update(EAMList);
               insertEAM= EAMList[0];
           }else{
                insertEAM.Attendee_Event_IDs__c= AttendeesList[0].Id+'-'+EventId;
                insertEAM.AS_id__c= AttendeesList[0].Id;
                insertEAM.EV_id__c= EventId; 
                insertEAM.Boothleads_Profile__c= 'Event Admin';
                insertEAM.IsCancelled__c = FALSE;
                insertEAM.GuestType__c= 'Event Admin';
                Database.Insert(insertEAM, FALSE);
                    
           }     
                    LIST<Dummay__c> checkGuestTicket= new LIST<Dummay__c>();
                    checkGuestTicket= [SELECT ID FROM Dummay__c WHERE Event_Attendee_Mapping__c =: insertEAM.id AND AttendeeSummary__c =: AttendeesList[0].Id AND TicketTypes__r.TT_Name__c =: 'Guest' AND Event__c =: EventId];
                    if(checkGuestTicket.size() ==0){
                        Constomer__c TransactionInfo = new Constomer__c();
                                    
                        TransactionInfo.Email__c= AttendeesList[0].AS_Email__c;
                        TransactionInfo.Customer_Name__c= AttendeesList[0].AS_FirstName__c+' '+AttendeesList[0].AS_LastName__c;
                        TransactionInfo.Isinserted__c = TRUE;        
                        Database.Insert(TransactionInfo,False);
                            
                        Dummay__c  RegistrationNewInfoForTicket= new Dummay__c();        
                            
                            LIST<TicketTypes__c> guestTicket= new LIST<TicketTypes__c>([SELECT ID, TT_Available__c, Available__c, TT_Sold__c FROM TicketTypes__c WHERE TT_Name__c =: 'Guest' AND EV_id__c =: EventId]);
                            RegistrationNewInfoForTicket.AttendeeSummary__c = AttendeesList[0].Id;
                            RegistrationNewInfoForTicket.Company__c = AttendeesList[0].AS_Company__c;
                            RegistrationNewInfoForTicket.Email__c = AttendeesList[0].AS_Email__c;
                            RegistrationNewInfoForTicket.Last_Name__c = AttendeesList[0].AS_LastName__c;
                            RegistrationNewInfoForTicket.First_Name__c = AttendeesList[0].AS_FirstName__c;
                            RegistrationNewInfoForTicket.Event__c = EventId;
                            RegistrationNewInfoForTicket.TicketTypes__c = guestTicket[0].Id;
                            RegistrationNewInfoForTicket.customer_key__c = TransactionInfo.Id;
                            RegistrationNewInfoForTicket.Update_with_created_date__c = Date.Today();
                            RegistrationNewInfoForTicket.Payment_Status__c =  'Paid';
                            RegistrationNewInfoForTicket.Payment_Type__c = 'Guest';
                            RegistrationNewInfoForTicket.Event_Attendee_Mapping__c =  insertEAM.id;
                            RegistrationNewInfoForTicket.Tickets_Quantty__c = 1;
                            //RegistrationNewInfoForTicket.Event_Attendee_Mapping__c = Event_Attendee.Id;
                            RegistrationNewInfoForTicket.TicketAmount__c= 0;
                            
                            Database.Insert(RegistrationNewInfoForTicket, FALSE);
                            if(guestTicket[0].Available__c <=0){
                                guestTicket[0].TT_Available__c += 1;
                            }
                            guestTicket[0].TT_Sold__c += 1;
                            Database.Update(guestTicket, FALSE);
                    }
                    
                }
        }    
        return null;    
    }
    
    public Pagereference insertGuestToAttendee(String EventId){
        
        LIST<Event_Attendee_Mapping__c> checkTicketForAttendee= new LIST<Event_Attendee_Mapping__c>();
        checkTicketForAttendee= [SELECT Id, GuestType__c, AS_ID__c, AS_ID__r.AS_FirstName__c, AS_ID__r.AS_LastName__c, AS_ID__r.AS_Email__c, AS_ID__r.AS_Company__c, 
                                 (SELECT ID FROM Individual_Ticket_Info__r) 
                                 FROM Event_Attendee_Mapping__c 
                                 WHERE EV_id__c =: EventId AND 
                                 IsCancelled__c =: FALSE];
        system.debug(checkTicketForAttendee.size()+'  ATTENDEES LIST '+checkTicketForAttendee);
        LIST<Event_Attendee_Mapping__c> toInsertGuestTicket= new LIST<Event_Attendee_Mapping__c>();        
        LIST<Event_Attendee_Mapping__c> toUpdateEAM= new LIST<Event_Attendee_Mapping__c>();        
        LIST<Constomer__c> insertTransactionInfo= new LIST<Constomer__c>(); 
        MAP<String, Constomer__c> customerKeyMAP= new MAP<String, Constomer__c>(); 
        LIST<Dummay__c> insertRegInfoList= new LIST<Dummay__c>();                     
        
        if(checkTicketForAttendee.size() >0){
            for(Event_Attendee_Mapping__c eam:checkTicketForAttendee){
                system.debug(eam.AS_Id__r.AS_Email__c+'  EAM GUEST TYPE '+eam.GuestType__c);
                if(eam.GuestType__c == NULL){
                    eam.GuestType__c= 'Attendee';
                    toUpdateEAM.add(eam);
                }
                system.debug(eam.id+'  '+eam.AS_Id__r.AS_Email__c+'  EAM GUEST TYPE '+eam.Individual_Ticket_Info__r.size());               
                if(eam.Individual_Ticket_Info__r.size() ==0){
                    Constomer__c TransactionInfo = new Constomer__c();
                    TransactionInfo.Email__c= eam.AS_ID__r.AS_Email__c;
                    TransactionInfo.Customer_Name__c= eam.AS_ID__r.AS_FirstName__c+' '+eam.AS_ID__r.AS_LastName__c;
                    TransactionInfo.Isinserted__c = TRUE; 
                    insertTransactionInfo.add(TransactionInfo);
                    toInsertGuestTicket.add(eam);                     
                }

            }
            Database.Insert(insertTransactionInfo, FALSE);
            system.debug(toUpdateEAM.size()+' UPDATE GUEST LIST '+toUpdateEAM);       
            Database.Update(toUpdateEAM, FALSE);
            system.debug(toInsertGuestTicket.size()+' INSERT GUEST LIST '+toInsertGuestTicket);
            for(Constomer__c key: insertTransactionInfo){
                customerKeyMAP.put(key.Email__c, key);
            }
            LIST<TicketTypes__c> guestTicket= new LIST<TicketTypes__c>([SELECT ID, TT_Sold__c, Available__c, TT_Available__c FROM TicketTypes__c WHERE TT_Name__c =: 'Guest' AND EV_id__c =: EventId]);
            Integer ticketsCountToDecrease=0;
            for(Event_Attendee_Mapping__c insertTicket: toInsertGuestTicket){
            
                Dummay__c  RegistrationNewInfo= new Dummay__c();        
                RegistrationNewInfo.AttendeeSummary__c = insertTicket.AS_ID__c;
                RegistrationNewInfo.Company__c = insertTicket.AS_ID__r.AS_Company__c;
                RegistrationNewInfo.Email__c = insertTicket.AS_ID__r.AS_Email__c;
                RegistrationNewInfo.Last_Name__c = insertTicket.AS_ID__r.AS_LastName__c;
                RegistrationNewInfo.First_Name__c = insertTicket.AS_ID__r.AS_FirstName__c;
                RegistrationNewInfo.Event__c = EventId;
                RegistrationNewInfo.TicketTypes__c = guestTicket[0].Id;
                RegistrationNewInfo.customer_key__c = customerKeyMAP.get(insertTicket.AS_ID__r.AS_Email__c).Id;
                RegistrationNewInfo.Update_with_created_date__c = Date.Today();
                RegistrationNewInfo.Payment_Status__c =  'Paid';
                RegistrationNewInfo.Payment_Type__c = 'Guest';
                RegistrationNewInfo.Event_Attendee_Mapping__c = insertTicket.id;
                RegistrationNewInfo.Tickets_Quantty__c = 1;
                RegistrationNewInfo.TicketAmount__c= 0;   
                insertRegInfoList.add(RegistrationNewInfo);
                ticketsCountToDecrease= ticketsCountToDecrease+1;
                                 
            }
            system.debug(insertRegInfoList.size()+' INSERT REG INFO LIST '+ticketsCountToDecrease+'  '+toInsertGuestTicket);
                Database.Insert(insertRegInfoList, FALSE);
                if(guestTicket[0].Available__c < ticketsCountToDecrease){
                    guestTicket[0].TT_Available__c= guestTicket[0].TT_Sold__c+ ticketsCountToDecrease;
                }
                guestTicket[0].TT_Sold__c += ticketsCountToDecrease;
                Database.Update(guestTicket, FALSE);
        }
        return null;        
    }
    
    public Boolean deleteEvent(String EventId){
        
        LIST<TicketTypes__c> ExistingTicketsList= new LIST<TicketTypes__c>();
        ExistingTicketsList= [SELECT ID, TT_Name__c FROM TicketTypes__c WHERE (TT_Name__c !=: 'Guest' AND TT_Name__c !=: 'Attendee Staff') AND EV_id__c =: EventId];
        LIST<Item__c> ExistingItemsList= new LIST<Item__c>();
        ExistingItemsList= [SELECT ID FROM Item__c WHERE Event__c =: EventId];
        LIST<Event_Attendee_Mapping__c> AttendeesList= new LIST<Event_Attendee_Mapping__c>();
        AttendeesList= [SELECT ID FROM Event_Attendee_Mapping__c WHERE EV_id__c =: EventId AND IsCancelled__c =: FALSE];
        Boolean isDelete= TRUE;
        system.debug(ExistingTicketsList.size()+'  TICKETS SIZE '+ExistingItemsList.size()+'  '+AttendeesList.size());
        if(ExistingTicketsList.size() >0 || ExistingItemsList.size() >0 || AttendeesList.size() >1){
            isDelete= FALSE;
        }
        system.debug('  BOOLEAN VALUE  '+isDelete);       
        return isDelete;    
    }
    
    
}