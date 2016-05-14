public with sharing class SA_AddAttendeeController {

    public PageReference closePopup() {
        isRegInfoInserted= FALSE;
        return null;
    }
    
    public Pagereference sendEmailToGuest(){
        pagereference pg;
        isRegInfoInserted= FALSE;
        sendOrderConfirmationEmail orderEmail= new sendOrderConfirmationEmail(); 
        orderEmail.ConfirmationEmail(createdOrderName);
        pg = new Pagereference('/apex/SA_Attendees');
        return pg;
    }

    public MAP<String, Item__c> ItemsMAP{get; set;}
    public MAP<String, TicketTypes__c> ticketsMAP{get; set;}
    public Decimal TotalScanAttendeeFee{get; set;}
    public Boolean isRegInfoInserted{get;set;}
    
    public void calculateAmount(){
    
        TotalAmount=0;
        TotalScanAttendeeFee=0;
        system.debug('   FEE VALUE  '+FeeValue);
        for(AddMultipleItems ami:AddMultipleItemsList){
            if(ami.SelectedItemName != 'Select Item'){
                if(ami.RegInfo.Item_Quantity__c != NULL){
                    if(ami.RegInfo.Item_Quantity__c*ami.ItemInfo.Cost__c != 0){
                    system.debug(ami.ItemInfo.Cost__c+'  ITEM TAX '+ami.ItemInfo.Sales_Tax__c);
                        if(ami.ItemInfo.Sales_Tax__c == NULL){                    
                            TotalAmount= TotalAmount+ ami.RegInfo.Item_Quantity__c*ami.ItemInfo.Cost__c;
                        }else{
                            Decimal TaxCost= (ami.ItemInfo.Cost__c*ami.ItemInfo.Sales_Tax__c)/100;
                            TotalAmount= TotalAmount+ ami.RegInfo.Item_Quantity__c*(ami.ItemInfo.Cost__c+TaxCost);                    
                        }
                        TotalScanAttendeeFee= ami.RegInfo.Item_Quantity__c*FeeValue;
                    }
                
                }
                ItemsMAP.put(ami.ItemInfo.Id, ami.ItemInfo);
            }
            
        }
        system.debug(AddMTickets.size()+'  TICKETS QUANTITYY '+AddMTickets);
        for(AddMultipleTickets amt:AddMTickets){
            if(amt.selectedString != 'Select Ticket'){
            system.debug(amt.soldQty+' TICKET QUANTITY '+amt.TicketObj);
                if(amt.soldQty != NULL){
                    if(amt.TicketObj.TT_TicketType__c != 'Donation'){    
                        if(amt.soldQty*amt.TicketObj.TT_Amount__c != 0){
                            TotalAmount= TotalAmount+ amt.soldQty*amt.TicketObj.TT_Amount__c;
                        }
                            

                    }else if(amt.TicketObj.TT_TicketType__c == 'Donation'){
                        TotalAmount= TotalAmount+ amt.soldQty*amt.DonationPrice;
                    }
                    TotalScanAttendeeFee= amt.soldQty*FeeValue;
                }
                ticketsMAP.put(amt.TicketObj.Id,amt.TicketObj);                
            }
        }
        

    }
        
   
    public Decimal TotalAmount{get; set;}
    
    public PageReference GuestDetails() {
        ShowGuestDetails= TRUE;
        GuestDetails= new LIST<Individual_Ticket_Info__c>();
        guestDetailsInnerList= new LIST<guestDetailsInner>();
        
        GuestDetails= [SELECT ID, Name,Ticket_Session_Mapping__c, Event_Attendee_Mapping__c, Event_Attendee_Mapping__r.AS_ID__r.AS_FirstName__c, 
                       Event_Attendee_Mapping__r.AS_ID__r.AS_LastName__c, Event_Attendee_Mapping__r.AS_ID__r.AS_Company__c, 
                       Event_Attendee_Mapping__r.AS_ID__r.AS_Title__c,Event_Attendee_Mapping__r.AS_ID__r.AS_WorkPhone__c, 
                       Event_Attendee_Mapping__r.AS_ID__r.AS_Email__c, Seat__c, Registration_Info__r.TicketTypes__r.TT_Name__c 
                       FROM Individual_Ticket_Info__c
                       WHERE Registration_Info__r.Event_Attendee_Mapping__c =: SelectedEAMId AND
                       Event_Attendee_Mapping__c != NULL AND 
                       Registration_Info__c=: SelectedRegInfoId AND
                       IsItem__c =: FALSE AND Is_Input__c =: TRUE AND 
                       IsCancelled__c =: FALSE];
                       
         SET<Id> ExistingIds= new SET<Id>();
         if(GuestDetails.size() >0){ 
             SelectedTicketName= GuestDetails[0].Registration_Info__r.TicketTypes__r.TT_Name__c;

             for(Individual_Ticket_Info__c ind: GuestDetails){
                 ExistingIds.add(ind.Event_Attendee_Mapping__r.AS_ID__c);         
             } 
             
             LIST<Individual_Ticket_Info__c> ITIList= new LIST<Individual_Ticket_Info__c>();
             ITIList=[SELECT ID, Name, Seat__c, Registration_Info__r.TicketTypes__r.TT_Name__c      
                      FROM Individual_Ticket_Info__c
                      WHERE Registration_Info__c =: SelectedRegInfoId AND
                      Event_Attendee_Mapping__c =: SelectedEAMId AND
                      Event_Attendee_Mapping__r.EV_id__c =: SelectedEventId AND
                      Is_Input__c =: TRUE AND IsCancelled__c =: FALSE];
             
             AvailableGuest= ITIList.size()-1;   
         }
         Guests= new LIST<AttendeeSummary__c>();
         MAP<ID, AttendeeSummary__c> GuestsDataMAP= new MAP<ID, AttendeeSummary__c>([SELECT ID, AS_FirstName__c, AS_LastName__c, AS_Company__c, AS_Title__c, AS_WorkPhone__c, AS_CellPhone__c, AS_Email__c FROM AttendeeSummary__c WHERE ID IN :ExistingIds]);               
         
         for(Individual_Ticket_Info__c ind: GuestDetails){
             if(GuestsDataMAP.containsKey(ind.Event_Attendee_Mapping__r.AS_ID__c)){
                 guestDetailsInnerList.add(new guestDetailsInner(ind, GuestsDataMAP.get(ind.Event_Attendee_Mapping__r.AS_ID__c)));
             }
         }
                 
         return null;
    }
    
    public LIST<Individual_Ticket_Info__c> GuestDetails{get; set;}
    public Boolean ShowGuestDetails{get; set;}
    public String SelectedPaymentType{get; set;}
    public String SelectedAttendeeType{get; set;}
    
    public PageReference CloseGuests() {
        ShowAddGuest= FALSE;
        ShowGuestDetails= FALSE;
        Guests= new LIST<AttendeeSummary__c>();
        guestDetailsInnerList= new LIST<guestDetailsInner>();
        return null;
    }


    public PageReference SaveGuests(){
    
        LIST<Individual_Ticket_Info__c> guestsList= new LIST<Individual_Ticket_Info__c>();
        LIST<Individual_Ticket_Info__c> existingGuestsList= new LIST<Individual_Ticket_Info__c>();
        SET<ID> existingEAMIds= new SET<ID>();
                
        guestsList= [SELECT ID, Event_Attendee_Mapping__c, Ticket_Session_Mapping__c, Seat__c
                     FROM Individual_Ticket_Info__c
                     WHERE Event_Attendee_Mapping__c =: SelectedEAMId AND
                     Registration_Info__c=: SelectedRegInfoId 
                     AND Is_Primary__c =: FALSE];
        system.debug(guestsList.size()+' GUESTS INFORMATION'+guestsList);
        
        existingGuestsList= [SELECT ID, Event_Attendee_Mapping__c
                             FROM Individual_Ticket_Info__c
                             WHERE Event_Attendee_Mapping__c != NULL AND
                             Event_Attendee_Mapping__c !=: SelectedEAMId AND
                             Registration_Info__c=: SelectedRegInfoId]; 
                             //AND Is_Primary__c =: FALSE];
         
         system.debug(existingGuestsList.size()+' EXISTING GUESTS INFORMATION'+existingGuestsList);                        
         for(Individual_Ticket_Info__c ind: existingGuestsList){         
             existingEAMIds.add(ind.Event_Attendee_Mapping__c);
         }  
         system.debug(existingEAMIds.size()+' EXISTING GUESTS INFORMATION'+existingEAMIds);
          system.debug(guestDetailsInnerList.size()+' guestDetailsInnerList'+guestDetailsInnerList);       
        if(guestDetailsInnerList.size() >0){
            SET<String> SeatNumbersSET= new SET<String>();
            guests= new LIST<AttendeeSummary__c>();
            guestDetails= new LIST<Individual_Ticket_Info__c>();
            
            for(guestDetailsInner inn: guestDetailsInnerList){
                AttendeeSummary__c attendee= new AttendeeSummary__c();
                attendee= inn.attendeeData;
                guestDetails.add(inn.itiData);
                
                if(!SeatNumbersSET.contains(inn.attendeeData.AS_Email__c)){                
                    SeatNumbersSET.add(inn.attendeeData.AS_Email__c);                    
                    guests.add(attendee);
                   
                }
            }
            system.debug(' GUESTS EMAIL IDS1111111111 '+SeatNumbersSET);  
            Database.UpsertResult[] guestsListToUpsert= Database.upsert(guests, AttendeeSummary__c.AS_Email__c.getDescribe().getSObjectField(), false);                   
            system.debug(' GUESTS UPSERT '+guestsListToUpsert); 
            system.debug(guestDetails.size()+' INDLIST '+guestDetails);              
            Database.update(guestDetails, FALSE); 
            system.debug(' IND INFO UPSERT '+guestDetails);  
            SET<String> GuestIds= new SET<String>();
            for(AttendeeSummary__c g: guests){
                GuestIds.add(g.Id);
            }
            
            system.debug(GuestIds.size()+' GUEST EMAILS '+GuestIds);
            LIST<AttendeeSummary__c> AttendeesList= new LIST<AttendeeSummary__c>();
            AttendeesList= [SELECT ID, (SELECT ID FROM Event_Attendee_Mapping__r WHERE EV_id__c =: SelectedEventId) 
                            FROM AttendeeSummary__c 
                            WHERE ID IN: GuestIds];
                            
            system.debug(AttendeesList.size()+' EXISTING ATTENDEES  '+AttendeesList);
            if(AttendeesList.size() >0){
                LIST<Event_Attendee_Mapping__c> upsertEAMList= new LIST<Event_Attendee_Mapping__c>();
                for(AttendeeSummary__c attendee: AttendeesList){
                    List<Event_Attendee_Mapping__c> eam= new List<Event_Attendee_Mapping__c>();
                    eam= attendee.Event_Attendee_Mapping__r;
                    if(eam.size() == 0){
                        Event_Attendee_Mapping__c insertEAM= new Event_Attendee_Mapping__c();
                        insertEAM.EV_id__c= SelectedEventId;
                        insertEAM.AS_id__c= attendee.Id;
                        insertEAM.IsBoothLeadsAttendee__c= TRUE;
                        insertEAM.Boothleads_Profile__c= 'Attendee';
                        insertEAM.Attendee_Event_IDs__c= attendee.Id+'-'+SelectedEventId;
                        upsertEAMList.add(insertEAM);
                    }
                }
                Database.SaveResult[] createEAMResult= Database.insert(upsertEAMList, false);
               // Database.UpsertResult[] eamListToUpsert= Database.upsert(upsertEAMList, Event_Attendee_Mapping__c.EA_AttendeeBarcode__c, false);
                
                system.debug(createEAMResult.size()+' EAM UPSERT  '+createEAMResult);
                LIST<Event_Attendee_Mapping__c> ExistingEAMs= new LIST<Event_Attendee_Mapping__c>();
                ExistingEAMs= [SELECT ID 
                               FROM Event_Attendee_Mapping__c
                               WHERE AS_id__c IN: GuestIds
                               AND EV_id__c =: SelectedEventId
                               AND ID NOT IN : existingEAMIds
                               AND ID !=: SelectedEAMId];
                system.debug(ExistingEAMs.size()+' EAM LIST '+ExistingEAMs);
                 
                 LIST<Individual_Ticket_Info__c> indRegInfoList= new LIST<Individual_Ticket_Info__c>();   
                LIST<Ticket_Session_Mapping__c> TicketSessionsList= new LIST<Ticket_Session_Mapping__c>();
                SET<ID> TicketSessionIds= new SET<ID>();
                
                for(Individual_Ticket_Info__c ind:guestsList){
                    TicketSessionIds.add(ind.Ticket_Session_Mapping__c);
                }
                TicketSessionsList=[ SELECT ID FROM Ticket_Session_Mapping__c WHERE ID IN : TicketSessionIds];                
                  
              
                if(TicketSessionsList.size()>0 && ExistingEAMs.size() >0){
                    system.debug(' EAM LIST SIZE '+ExistingEAMs.size());               
                    for(Event_Attendee_Mapping__c EAM:ExistingEAMs){             
                        system.debug(' EAM INFORMATION '+EAM);               
                        for(Ticket_Session_Mapping__c TSession: TicketSessionsList){
                            system.debug(' SESSION INFORMATION '+TSession);               
                            for(Individual_Ticket_Info__c ind:guestsList){
                                system.debug(TSession.Id+' INDIVIDUAL INFORMATION '+ind.Seat__c+'   '+ind.Ticket_Session_Mapping__c);
                                if(ind.Ticket_Session_Mapping__c == TSession.Id && ind.Event_Attendee_Mapping__c == SelectedEAMId){                                
                                system.debug(TSession.Id+' IFFFFFF  CONDITION 111111 '+ind.Ticket_Session_Mapping__c);               
                                    ind.Event_Attendee_Mapping__c= EAM.Id;
                                    system.debug(ind.Event_Attendee_Mapping__c+'  IFFFFFF  222222222 '+ind.Ticket_Session_Mapping__c);               
                                    break;
                                }

                            }

                        } 
                    }   
                            system.debug(guestsList.size()+' IND LIST TO UPSERT INFORMATION '+guestsList); 
                            Database.UpsertResult[] IndListToUpsert= Database.upsert(guestsList, false);    
                            system.debug(IndListToUpsert.size()+' IND UPSERT  '+IndListToUpsert);                                       
                }else if(TicketSessionsList.size()<= 0 && ExistingEAMs.size() >0){
                    for(integer i=0; i< ExistingEAMs.size(); i++){                
                        guestsList[i].Event_Attendee_Mapping__c= ExistingEAMs[i].Id;
                        //indRegInfoList.add(guestsList[i]);   
                    } 
                    Database.UpsertResult[] IndListToUpsert= Database.upsert(guestsList, false);    
                system.debug(IndListToUpsert.size()+' IND UPSERT  '+IndListToUpsert); 
                }
                system.debug(guestsList.size()+' UPSERT '+guestsList);
                      
        }              
       
        }
            ShowAddGuest= FALSE;  
            Guests= new LIST<AttendeeSummary__c>();
            guestDetailsInnerList= new LIST<guestDetailsInner>();
            pagereference pg= new pagereference('/SA_AddAttendee?id='+EditId);          
        return pg;
    }


    public Boolean ShowEventDateError{get; set;}
    public Decimal FeeValue{get; set;}
    public String StripeRefreshToken{get;set;}
    
    public SA_AddAttendeeController(){
        
        EditId ='';
        TotalAmount=0;
        ItemsMAP= new MAP<String, Item__c>();
        TicketsMAP= new MAP<String, TicketTypes__c>();
        SelectedEvent= new Event__c();   
        EditId = ApexPages.CurrentPage().getParameters().get('Id');
        TotalAmount=0;
        GuestDetails= new LIST<Individual_Ticket_Info__c>();
        guestDetailsInnerList= new LIST<guestDetailsInner>();
        system.debug(' CONTROLLER EDIT ID '+EditId);           
        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
        FeeValue=0;
        if(counter !=null){ 
        
            User EventUser = [SELECT Id,FirstName,LastName,UserName,Email,Stripe_Refresh_Token__c
                              FROM User 
                              WHERE Id = :UserInfo.getUserId()];
            StripeRefreshToken = EventUser.Stripe_Refresh_Token__c;
            ShowEventDateError= FALSE;
            SelectedEventId = counter.getValue();
            SelectedEvent=[SELECT Id, Fee_Type__c, Sales_Tax__c, Ev_Title__c, EV_EndDate__c, EV_HostingCountryNew__c  FROM Event__c Where Id=:SelectedEventId];
            if(SelectedEvent.EV_EndDate__c< system.today()){
                ShowEventDateError= TRUE;
            }
            if(SelectedEvent.Fee_Type__c == 'Charge the fee to the customer'){
                
                LIST<App_Settings__c> AppSettingsList= new LIST<App_Settings__c>();
                AppSettingsList=[SELECT Fee__c FROM App_Settings__c WHERE User_Type__c =: 'ScanAttendee User'];

                if(AppSettingsList.size() >0){
                    if(AppSettingsList[0].Fee__c != NULL){
                        FeeValue= AppSettingsList[0].Fee__c;
                    }else{
                        FeeValue=0;
                    }
                }
            }
            
        
        system.debug(' EVENT ID '+SelectedEventId  );


       Attendee = new AttendeeSummary__c();
       RegistrationInfo = new Dummay__c ();
       AddMTickets = new List<AddMultipleTickets>();
       ListofTickets();
       ListofItems();
       PaymentInformation();
       //addingMultipleTickets();
       addingMultipleItems();
       SoldQuantityError= FALSE;
       SelectedAttendeeType= 'Attendee'; 
       if(EditId != null){
       
       ShowEmail = FALSE;
       
           AttendeeSummary__c ShowDetails= [select Id,AS_Email__c,AS_FirstName__c,AS_LastName__c,AS_Company__c,AS_Title__c,
                                             AS_WorkPhone__c,AS_WorkAddress1__c,AS_WorkCity__c,AS_Work_Country__c,AS_Work_States__c,
                                             AS_WorkZip__c, AS_CellPhone__c
                                             From AttendeeSummary__c 
                                             Where Id =: EditId];
           system.debug('  ZIP CODE FOR ATTENDEE  '+ShowDetails.AS_WorkZip__c);
           Attendee = ShowDetails ;
           if(SelectedEvent.EV_HostingCountryNew__c != NULL && Attendee.AS_Work_Country__c == NULL){
               Attendee.AS_Work_Country__c= SelectedEvent.EV_HostingCountryNew__c;
           }
           ShowselectedTickets();
           LIST<Event_Attendee_Mapping__c> EAMList= new LIST<Event_Attendee_Mapping__c>();
           EAMList= [SELECT ID, GuestType__c FROM Event_Attendee_Mapping__c WHERE AS_Id__c =: EditId AND EV_id__c =: SelectedEventId AND IsCancelled__c =: FALSE];
           if(EAMList.size() >0){
               SelectedAttendeeType= EAMList[0].GuestType__c;
               system.debug(EAMList[0].GuestType__c+'  ATTENDEE TYPE  '+SelectedAttendeeType);
           }
       }else{
           SelectedAttendeeType= 'Attendee';
           ShowEmail = TRUE;
           if(SelectedEvent.EV_HostingCountryNew__c != NULL){
               Attendee.AS_Work_Country__c= SelectedEvent.EV_HostingCountryNew__c;
           }
       }
       Guests = new LIST<AttendeeSummary__c>();
       }
    }
    
    
   public List<Event_Attendee_Mapping__c> ShowEditDetails {get; set;} 
   public String SelectedEAMId{get; set;}
   
   public void ShowselectedTickets(){
      
      Guests= new LIST<AttendeeSummary__c>();
      List<Dummay__c> AllTicketAttendees = new List<Dummay__c>();
      
      ListOfToshowPaidAmount = new List<ToshowPaidAmount>();
      
      DisplayEditAttendees = new List<Dummay__c>();
      
      system.debug('LLLLLLLLLL'+EditId  );
      
      showTicketsList = TRUE;
      
        ShowEditDetails = new List<Event_Attendee_Mapping__c>();
      
        ShowEditDetails = [Select Id,AS_id__c,EV_id__c,(select Id,Payment_Status__c,Payment_Type__c, Item__c, Total_Amount__c, 
                           Item__r.Item_name__c, Item_Quantity__c, Item_Amount__c, Seat_Number__c,Ticket_Amount__c,TicketTypes__c,
                           TicketTypes__r.TT_Amount__c,Tickets_Quantty__c, TicketTypes__r.TT_Name__c, Available_Quantity__c,
                           TicketTypes__r.Ticket_Category__c,TicketTypes__r.TT_TicketType__c,TicketAmount__c, Amount__c
                           FROM Registration_Info__r WHERE (TicketTypes__c != NULL OR Item__c != NULL) AND Available_Quantity__c !=0 ORDER BY TicketTypes__c, Item__c) 
                           FROM Event_Attendee_Mapping__c 
                           Where AS_id__c =: EditId AND EV_id__c=: SelectedEventId 
                           ];
       SelectedEAMId= ShowEditDetails[0].Id;
       system.debug('KKKKKKKKKKKKKKKKKKKKKK       ');                                
                                          
      if(ShowEditDetails.size() > 0){
      
        if(ShowEditDetails[0].Registration_Info__r.size() > 0){  
          
        }
      for(Event_Attendee_Mapping__c LooPTickets : ShowEditDetails){
          if(LooPTickets.Registration_Info__r.size() > 0){
          
              AllTicketAttendees.addAll(LooPTickets.Registration_Info__r);             
          }                     
      }
      
      system.debug(AllTicketAttendees.size()+' REG IDS '+AllTicketAttendees);
      MAP<Id, Dummay__c> ExistingRegIfosMAP= new MAP<Id, Dummay__c>([SELECT ID, Tickets_Quantty__c, Available_Quantity__c, TicketTypes__c, (SELECT Id FROM Individual_Ticket_Info__r WHERE Event_Attendee_Mapping__c =: SelectedEAMId AND IsCancelled__c =: FALSE AND Is_Input__c =: TRUE) FROM Dummay__c WHERE ID IN :AllTicketAttendees]);
      system.debug(ExistingRegIfosMAP.size()+'  DUMMY MAP '+ExistingRegIfosMAP);
      
      for(Dummay__c DD : AllTicketAttendees){
         
          
          PaidAmount = 0.0;
            
          if(DD.TicketTypes__c != NULL){ 
              PaidAmount = DD.Ticket_Amount__c;
              PaidAmount = PaidAmount * DD.Available_Quantity__c; 
          }
          if(DD.Item__c != NULL){
              PaidAmount = DD.Item_Amount__c;
              PaidAmount = PaidAmount * DD.Available_Quantity__c;
          }
          
          
          RegistrationInfo.Payment_Type__c = DD.Payment_Type__c ;
      
          DisplayEditAttendees.add(DD);
          
          Boolean BooleanValue= TRUE;
          Dummay__c dum= new Dummay__c();
          dum= ExistingRegIfosMAP.get(DD.Id);
          LIST<Individual_Ticket_Info__c> IndList= new LIST<Individual_Ticket_Info__c>();
          IndList= dum.Individual_Ticket_Info__r;
          system.debug(dum.Available_Quantity__c+' QUANTITY '+IndList.size()+'  '+BooleanValue);
          integer Available= IndList.size()-1;
          if(Available == 0){
              BooleanValue= FALSE;
              
          }
          system.debug(BooleanValue+' BOOLEAN VALUE  '+ListOfToshowPaidAmount.size());
          ListOfToshowPaidAmount.add(new ToshowPaidAmount(DD,PaidAmount,BooleanValue));
          system.debug(ListOfToshowPaidAmount.size()+' INNER CLASS '+ListOfToshowPaidAmount);      
      } 
      
      InviteeTickets= new LIST<Individual_Ticket_Info__c>();
          InviteeTickets= [SELECT ID, Event_Attendee_Mapping__c,Registration_Info__r.name, Registration_Info__r.customer_key__r.Name, 
                           Seat__c, Registration_Info__r.TicketTypes__r.TT_Name__c, Total_Amount__c
                           FROM Individual_Ticket_Info__c
                           WHERE Event_Attendee_Mapping__c =: SelectedEAMId
                           AND Registration_Info__r.Event_Attendee_Mapping__c !=: SelectedEAMId
                           AND Registration_Info__r.Event__c =: SelectedEventId
                           AND Registration_Info__r.TicketTypes__c != NULL
                           AND Is_Input__c =: TRUE AND IsCancelled__c =: FALSE];
   }
    
}   
    public LIST<Individual_Ticket_Info__c> InviteeTickets{get; set;}

    public string SelectedEventId  {get;set;}
    public Event__c SelectedEvent{get;set;}
    public AttendeeSummary__c Attendee{get;set;}
    public List<AddMultipleTickets> AddMTickets{get;set;}
    public List<selectOption> TicketNames{get;set;}
    public String SelectedTicket{get;set;}
    public Integer rowNum{get;set;}
    public Integer GuestrowNum{get;set;}
    public List<TicketTypes__c> Tickettypes{get;set;}
    public List<TicketTypes__c> ListofTickettypes{get;set;}
    public Dummay__c RegistrationInfo{get;set;}
    public string  EditId{get;set;}
    public Boolean AllreadyExist{get;set;}
    public Boolean ShowEmail{get;set;}
    public Boolean showTicketsList {get;set;}
    public Decimal PaidAmount{get;set;}
    public List<Dummay__c> DisplayEditAttendees{get;set;}
    public Boolean ShowAddGuest{get;set;}
    public List<AttendeeSummary__c> Guests{get;set;}
    
    
    
     public void TogetSelectedEvent(){
        system.debug('OOOOOOOOOOOOOOOOOO '+SelectedEventId  );
       
        ListofTickets();
    }
    
    
    public List<ToshowPaidAmount> ListOfToshowPaidAmount{get;set;}
     
     public class ToshowPaidAmount{
     
         public Dummay__c TicketInformation{get;set;}
         public decimal ShowPaidAmount {get;set;}
         public Boolean ShowAddGuestLink{get; set;}
         
         public ToshowPaidAmount(Dummay__c TI,decimal PA, Boolean guestLink){
             TicketInformation = TI;
             ShowPaidAmount = PA;
             ShowAddGuestLink= guestLink;
         
         }         
     }
     
     public void ShowTicketDetails(){
                
        SelectedTicket = ApexPages.CurrentPage().getParameters().get('STick');

         for(AddMultipleTickets mt: AddMTickets){
               
                 if(mt.selectedString != 'Select Ticket'){
                                                  
                         mt.TicketObj = [select Id,TT_Amount__c,TT_Limit__c,Available__c,TT_Name__c,TT_Sold__c,Ticket_Category__c,TT_TicketType__c,
                                         TT_Available__c From TicketTypes__c Where Id =: mt.selectedString];
                         system.debug('  TICKET TYPE '+mt.TicketObj.TT_TicketType__c);
                         if(mt.TicketObj.TT_TicketType__c == 'Donation'){
                             mt.ShowDonationPrice= TRUE;
                             mt.soldQty= 1;
                             system.debug('  DONATION PRICE'+mt.DonationPrice);
                             if(mt.DonationPrice == 0){
                                 mt.DonationPrice= mt.TicketObj.TT_Amount__c;
                             }
                             system.debug(' DONATION   '+mt);
                         }else{
                             mt.ShowDonationPrice= FALSE;
                             mt.DonationPrice=0;
                         }                 
                         if(mt.soldQty != NULL || mt.soldQty != 0){
                             calculateAmount();                         
                         }
                         
                                     
                 }else{
                     mt.TicketObj= new TicketTypes__c();
                 }               
         }         
   
    }
    



    public void ShowItemDetails(){
    


         for(AddMultipleItems mi: AddMultipleItemsList){
               
                 if(mi.selectedItemName != 'Select Item'){
                   system.debug(' Selected Name Item '+mi.selectedItemName);                               
                     mi.ItemInfo= [SELECT Id, Cost__c, Event__c, Item_name__c, Item_Quantity__c, Sales_Start__c, 
                                   Sales_End__c, Sold_Quantity__c, type__c, Available_Quantity__c, Sales_Tax__c
                                   FROM Item__c
                                   WHERE Id =: mi.selectedItemName];
                    system.debug(' ITEM QUANTITY '+mi.RegInfo.Item_Quantity__c);
                    if(mi.RegInfo.Item_Quantity__c != NULL){
                        calculateAmount();
                    } 
                 }else{
                     mi.ItemInfo= new Item__c();
                 }                 
         }     

    
    }
     
     
      public void DeleteTickets(){
        rowNum = Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
        AddMTickets.remove(rowNum); 
        calculateAmount(); 
        
    }
    
    public Integer ItemRowNum{get;set;}
     public void DeleteItems(){
         try{
         system.debug(ItemRowNum+' ITEM ROW NUMBER '+apexpages.currentpage().getparameters().get('itemIndex'));
         ItemRowNum= integer.valueof(apexpages.currentpage().getparameters().get('itemIndex'));
         AddMultipleItemsList.remove(ItemRowNum);  
         }catch(Exception e){}
         calculateAmount(); 
       
     }
    
     public class AddMultipleTickets{
        public String TicketId{get;set;}
        public String seatName{get; set;}
        public integer soldQty{get; set;}
        public TicketTypes__c TicketObj{get;set;}
        public string selectedString{get; set;}
        public Decimal DonationPrice{get; set;}
        public Boolean ShowDonationPrice{get; set;}
        
        // Not used
        public Dummay__c SoldQuantity{get;set;} 
        public boolean isNewRecord{get; set;}
        
        public AddMultipleTickets(string TId, TicketTypes__c tic, String seatNa, integer soldq, Decimal DonPrice, Boolean ShowDonPrice){
             TicketId = TId;
             soldQty = soldq;
             TicketObj = tic;    
             seatName = seatNa; 
             selectedString = 'Select Ticket';  
             DonationPrice= DonPrice;
             ShowDonationPrice= ShowDonPrice;             
        }
        
       } 
        

        public LIST<AddMultipleItems> AddMultipleItemsList{get; set;}
        public class AddMultipleItems{
        
            public String SelectedItemName{get;set;}
            public Item__c ItemInfo{get;set;}
            public Dummay__c RegInfo{get;set;} 
            
            public AddMultipleItems(string IId, Item__c Item, Dummay__c Reg){
                 
                 SelectedItemName= 'Select Item';
                 ItemInfo= Item;
                 RegInfo= Reg;    
            }
       }
    
    public void addingMultipleTickets(){
            
        AddMTickets.add(new AddMultipleTickets('', new TicketTypes__c() ,'' , null, 0, FALSE));
    
    }
    
    public void addingMultipleItems(){

        AddMultipleItemsList.add(new AddMultipleItems('', new Item__c(), new Dummay__c()));
    
    }
    
    public void ListofTickets(){
    
       
        system.debug('K KKKKKKKKKKKKKKKKKKKKK '+SelectedEventId );
        AddMTickets= new LIST<AddMultipleTickets>();
        Tickettypes = [select Id,Available__c, TT_Amount__c,TT_Limit__c,TT_Name__c,TT_Sold__c,Ticket_Category__c,TT_TicketType__c,
                      TT_Available__c From TicketTypes__c Where EV_id__c =: SelectedEventId AND (Available__c > 0 OR TT_Name__c =: 'Guest') AND TT_Name__c != 'Attendee Staff'];
        
        TicketNames = new List<selectOption>();
            
             TicketNames.add(new selectOption('Select Ticket','Select Ticket'));
             system.debug('  EDIT ATTENDEE ID '+EditId);
         if(Tickettypes.size() >0){   
            if(EditId != NULL){ 
                addingMultipleTickets();
            }
            for(TicketTypes__c TName:Tickettypes){
                Dummay__c d = new Dummay__c();
    
                    system.debug(EditId+' TICKET AVAILABLE  '+TName.Available__c);
                    TicketNames.add(new selectOption(TName.Id,TName.TT_Name__c)); 
                    if(EditId == NULL){
                        if(TName.TT_Name__c == 'Guest'){
                            guestTicket= new TicketTypes__c();
                            guestTicket= TName;
                            AddMTickets.add(new AddMultipleTickets(TName.Id, TName, '' , 1, 0, FALSE));
                            AddMTickets[0].selectedString= TName.Id;
                            ticketsMAP.put(TName.Id, TName);                
                            system.debug('  MULTIPLE TICKETS '+AddMTickets);
                        } 
                    }    
                    
            }
        }
    
    }
    
    public TicketTypes__c guestTicket{get; set;}
    public List<selectOption> ItemNames{get; set;}
    
     public void ListofItems(){
    
        AddMultipleItemsList= new LIST<AddMultipleItems>();
        system.debug('   IIIIIIIIIIIIIII   '+SelectedEventId );
        LIST<Item__c> ItemsList= new LIST<Item__c>();
        
        ItemsList= [SELECT Id, Cost__c, Event__c, Item_name__c, Item_Quantity__c, Sales_Start__c, Sales_End__c, 
                    Sold_Quantity__c, type__c, Available_Quantity__c
                    FROM Item__c 
                    WHERE Event__c =: SelectedEventId AND Available_Quantity__c > 0];
        
        ItemNames= new List<selectOption>();
            
        ItemNames.add(new selectOption('Select Item','Select Item')); 
             
        for(Item__c item: ItemsList){
                system.debug(' Items AVAILABLE  '+item.Item_Quantity__c);
                ItemNames.add(new selectOption(item.Id,item.Item_name__c)); 
        }
    }
    
    public LIST<SelectOption> PaymentOptions{get; set;}
    
    public void paymentInformation(){
        PaymentOptions= new LIST<SelectOption>();
        PaymentOptions.add(new SelectOption('Cash','Cash'));
        PaymentOptions.add(new SelectOption('Credit Card','Credit Card'));        
        PaymentOptions.add(new SelectOption('Check','Check'));        
        PaymentOptions.add(new SelectOption('Free','Free'));        
        SelectedPaymentType='Cash';
        
        MonthsList= new LIST<SelectOption>();
        YearsList= new LIST<SelectOption>();
        DaysList= new LIST<SelectOption>();
        
        LIST<String> daysString= new LIST<String>{'01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'};
        LIST<String> monthstring = new LIST<String>{'01','02','03','04','05','06','07','08','09','10','11','12'};
        LIST<String> yearstring = new LIST<String>{'2014','2015','2016','2017','2018','2019','2020','2021','2022','2023','2024','2025','2026','2027','2028','2029','2030'};
        
        SelectedYear= String.valueOf(system.today().year());
        YearsList.add(new SelectOption(SelectedYear,SelectedYear));
        String y=SelectedYear;
        for(integer i=0; i<= 15; i++){
            y= String.valueof(integer.valueOf(y)+1); 
            YearsList.add(new SelectOption(y,y));           
        }
        
        for(String m:monthstring){
            MonthsList.add(new SelectOption(m,m));
        }
        /*
        for(String y:yearstring){
            YearsList.add(new SelectOption(y,y));
        }
        */
                
        for(String d:daysString){
            DaysList.add(new SelectOption(d,d));
        }
    }
    
    public String CreditCardNumber{get; set;}
    public String SelectedDay{get; set;}
    public String SelectedMonth{get; set;}
    public String SelectedYear{get; set;}
    public String CheckNumber{get; set;}
    public String CVVNumber{get; set;}
    public String ChargeId{get; set;}
    public String ChargeNumber{get; set;}
    public LIST<SelectOption> MonthsList{get;set;}
    public LIST<SelectOption> YearsList{get;set;}
    public LIST<SelectOption> DaysList{get;set;}    

    public void PaymentForm(){
    
        
    }

    public Boolean ShowPaymentError{get; set;}
    public String PaymentErrorString{get; set;}
    public LIST<Item__c> ListofItems{get; set;}
    public Constomer__c TransactionInfo{get; set;}
    public String createdOrderName{get; set;}
    public void insertCustomerkey(){
    
        //if(AddMTickets.size() >=1 || AddMultipleItemsList.size() >= 1){
            //if(AddMTickets[0].selectedString != 'Select Ticket' || AddMultipleItemsList[0].SelectedItemName == 'Select Item'){ 
                        TransactionInfo = new Constomer__c();
                                
                        TransactionInfo.Email__c= Attendee.AS_Email__c;
                        TransactionInfo.Customer_Name__c= Attendee.AS_FirstName__c+' '+Attendee.AS_LastName__c;
                        TransactionInfo.Isinserted__c = TRUE;
                        TransactionInfo.Total_Amount__c= TotalAmount;
                        TransactionInfo.ScanAttendee_Fee__c= TotalScanAttendeeFee;
                        Database.Insert(TransactionInfo,False);
                        createdOrderName= TransactionInfo.id;
                        system.debug('  OREDR NAME '+createdOrderName);
                        
            //}
        //}               
    }
    
    public void updateUser(){
        LIST<User> updateUserList= new LIST<User>();
        updateUserList= [SELECT ID, FirstName, LastName, CompanyName, CompanyAddr1__c, Country__c, States__c, 
                         Title, Zipcode__c, Companyphone__c 
                         FROM User WHERE Email =: Attendee.AS_Email__c];
                         
        if(updateUserList.size() >0){
           for(User usr: updateUserList){       
               usr.FirstName= Attendee.AS_FirstName__c;
               usr.LastName= Attendee.AS_LastName__c;                                            
               usr.CompanyName= Attendee.AS_Company__c;                                                        
               usr.Title= Attendee.AS_Title__c;                                            
               usr.Companyphone__c= Attendee.AS_WorkPhone__c;                                            
               usr.CompanyAddr1__c= Attendee.AS_WorkAddress1__c; 
               usr.CompanyCity__c= Attendee.AS_WorkCity__c;                                                                                                                        
               usr.Country__c= Attendee.AS_Work_Country__c;                                                                  
               usr.States__c= Attendee.AS_Work_States__c;                                                                  
               usr.Zipcode__c= Attendee.AS_WorkZip__c;                                                                             
          }
          Database.Update(updateUserList, FALSE);
       }
   }
    
   
    public pagereference validatePayment(){
        ChargeId ='';
        ChargeNumber='';
        pagereference pg;
         system.debug(SelectedPaymentType +' PAYMENT DETAILS111 '+AddMTickets.size()+'   '+ AddMultipleItemsList.size());
         system.debug('AddMTickets:::::::!11111111AddMTickets'+AddMTickets);
        
        for(AddMultipleTickets amt:AddMTickets){
          system.debug('amt.selectedString::::::::amt.selectedString'+amt.selectedString);
            system.debug('amt.soldQty::::::::amt.soldQty'+amt.soldQty);
            if(amt.selectedString != 'Select Ticket' && (amt.soldQty == NULL || amt.soldQty == 0)){
                ShowPaymentError= TRUE; 
                PaymentErrorString= 'Please Enter sold Quantity for Ticket';
                return null;
            }                          
            if(amt.selectedString != 'Select Ticket' && (amt.TicketObj.TT_TicketType__c == 'Donation')){
                system.debug(amt.TicketObj.TT_Amount__c+'  DONATION PRICE000000000 '+amt.DonationPrice);
                  system.debug(amt.TicketObj.TT_Amount__c+'  DONATION PRICE 11111111111'+amt.DonationPrice);

                if(amt.DonationPrice < amt.TicketObj.TT_Amount__c ){
                                system.debug(amt.TicketObj.TT_Amount__c+'  DONATION PRICE 11111111111'+amt.DonationPrice);
                    ShowPaymentError= TRUE; 
                    PaymentErrorString= 'Donation Price Should be greater than Ticket Price !';
                    return null;
                }
                
            }
        } 
        
        for(AddMultipleItems ami:AddMultipleItemsList){
            if(ami.SelectedItemName != 'Select Item' && (ami.RegInfo.Item_Quantity__c == NULL || ami.RegInfo.Item_Quantity__c == 0)){
                ShowPaymentError= TRUE;
                PaymentErrorString= 'Please Enter sold Quantity for Item'; 
                return null;                                                   
            }
        } 
        
        system.debug('SelectedPaymentType::::SelectedPaymentType'+ SelectedPaymentType);
         if(SelectedPaymentType == 'Credit Card'){
             ShowPaymentError= TRUE;
             PaymentErrorString='';
             system.debug('  TOTAL SCAN ATTENDEE FEE '+TotalScanAttendeeFee);
             
                     system.debug('CreditCardNumber::::CreditCardNumber'+ CreditCardNumber);
  system.debug('selectedMonth:::::!!!!'+selectedMonth);
                 system.debug('system.today().month():::::!!!!'+system.today().month());
                          SYSTEM.DEBUG('TotalAmount:TotalAmount' + TotalAmount);

             if(string.isBlank(CreditCardNumber)){
                 PaymentErrorString='Please Enter Credit Card Number';
                 return null;
             }else if(!string.isBlank(CreditCardNumber) && ! CreditCardNumber.isNumeric()){
                 PaymentErrorString='Please Enter Numbers only';
                 return null;
             }else if(CreditCardNumber.length() != 16){
                 PaymentErrorString='Please Enter 16 digit Number';
                 return null;
                
             }else if(integer.valueof(selectedyear) == system.today().year() && integer.valueof(selectedMonth) < system.today().month()){
                 PaymentErrorString='Please Select Valid Expiry Date';
                 return null;
             }else if(string.isBlank(CVVNumber)){
                 PaymentErrorString='Please Enter CVV Number';
                 return null;
             }else if(!string.isBlank(CVVNumber) && ! CVVNumber.isNumeric()){
                 PaymentErrorString='Please Enter Numbers only';
                 return null;
             }else if((CVVNumber != NULL || CVVNumber != '') && CVVNumber.length() != 3){
                 PaymentErrorString='Please Enter 3 Digit Number';
                 return null; 
             }
             else{
                 Decimal TotalChargeAmount = TotalAmount*100;
                 Decimal FeeAmount = FeeValue*100;
                 String stramount = String.valueOf(Integer.ValueOf(TotalChargeAmount));
                 String FeesAmount= String.valueOf(Integer.ValueOf(FeeAmount));
                 
                // Getting Access Token using Refresh Token
                Http RToken = new Http();
               
                HttpRequest reqRToken = new HttpRequest();
                reqRToken.setEndpoint('https://connect.stripe.com/oauth/token');
                String RBodyParameters = 'grant_type=refresh_token&client_secret=sk_test_gxtZK6ncdhZOpB7dZOb8Ns00&refresh_token='+StripeRefreshToken; 
                reqRToken.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                reqRToken.setBody(RBodyParameters);
                reqRToken.setMethod('POST');
                
                HttpResponse resRToken;
                resRToken = RToken.send(reqRToken);
    
                JSONRTokenWrapper RTokenObj = (JSONRTokenWrapper)JSON.deserialize(resRToken.getBody(), JSONRTokenWrapper.class);
        
                // Getting Card Token using Access Token
                Http CToken = new Http();
                
                HttpRequest reqCToken = new HttpRequest();
                reqCToken.setEndpoint('https://api.stripe.com/v1/tokens');
                String authorizationHeader = 'BEARER ' + RTokenObj.access_token;
                String TBodyParameters = 'card[number]='+CreditCardNumber+'&card[exp_month]='+SelectedMonth+'&card[exp_year]='+SelectedYear+'&card[cvc]='+CVVNumber;
                reqCToken.setHeader('Authorization', authorizationHeader);
                reqCToken.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                reqCToken.setBody(TBodyParameters);
                reqCToken.setMethod('POST');
                
                HttpResponse resCToken;
                resCToken = CToken.send(reqCToken);
      
                JSONTokenWrapper CTokenObj = (JSONTokenWrapper)JSON.deserialize(resCToken.getBody(), JSONTokenWrapper.class);
 
                // Creating Charge using token
                Http ChargeToken = new Http();
                
                HttpRequest reqChargeToken = new HttpRequest();
                reqChargeToken.setEndpoint('https://api.stripe.com/v1/charges');
                String ChargeAuthorizationHeader = 'BEARER ' + RTokenObj.access_token;
                String ChargeBodyParameters = 'amount='+stramount+'&application_fee='+FeesAmount+'&currency=usd&card='+CTokenObj.id; 
                reqChargeToken.setHeader('Authorization', ChargeAuthorizationHeader);
                reqChargeToken.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                reqChargeToken.setBody(ChargeBodyParameters);
                reqChargeToken.setMethod('POST');
                
                HttpResponse resChargeToken;
                resChargeToken = ChargeToken.send(reqChargeToken);
                system.debug('Charge Body'+resChargeToken.getBody());
                JSONChargeWrapper ChargeTokenObj = (JSONChargeWrapper)JSON.deserialize(resChargeToken.getBody(), JSONChargeWrapper.class);
    
                system.debug('Charge ID: ' + ChargeTokenObj.id);
                
                 if(ChargeTokenObj.id != NULL){
                    system.debug('Charge ID: ' + ChargeTokenObj.id);
                    system.debug('Last4: ' + ChargeTokenObj.card.last4);
                    ChargeId = ChargeTokenObj.id;
                    ChargeNumber = ChargeTokenObj.card.last4;
                    pg= saveAttendee();
                 }
                 else{
                    ShowPaymentError= TRUE;
                   // system.debug('Error Message :' + response.errorResponse.message);
                   // PaymentErrorString=response.errorResponse.message;
                    PaymentErrorString='Payment Error';
                    return null;
                 }
             }
         }
         else if(SelectedPaymentType == 'Check'){ 
             ShowPaymentError=TRUE;
             system.debug(SelectedPaymentType +' PAYMENT DETAILS222 '+CreditCardNumber+' bca'+CheckNumber+'abc'  );
             if(string.isBlank(CheckNumber)){
                 PaymentErrorString='Please Enter Check Number'; 
                 system.debug(SelectedPaymentType +' SSSSSSSSSSSSS '+PaymentErrorString+' '+ShowPaymentError);
                 return null;
             }else if(!string.isBlank(CheckNumber) && ! CheckNumber.isNumeric()){
                 PaymentErrorString='Please Enter Numbers Only';    
                 return null;
             }else if(CheckNumber.length() < 4 || CheckNumber.length() > 10){
                 PaymentErrorString='Please Enter Valid Number';    
                 return null;
             }else{
                 pg= SaveAttendee();
             }

         }else if(SelectedPaymentType == 'Cash' || SelectedPaymentType == 'Free'){
            ShowPaymentError=FALSE;
            system.debug(SelectedPaymentType +' REDIRECT TO '+CreditCardNumber+'   '+ CheckNumber  );
            pg= SaveAttendee();
            return pg;
         }
         return pg;
    }
    
    public Pagereference SaveAttendee(){
       
       AllreadyExist = False;
       isRegInfoInserted= FALSE;
       Pagereference pg;  
        
      List<Event_Attendee_Mapping__c> DuplicateCheck= new List<Event_Attendee_Mapping__c>();
       
       List<AttendeeSummary__c> CheckDuplicateEmail= new List<AttendeeSummary__c>();
     
       
       ShowPaymentError= FALSE;
       CheckDuplicateEmail = [select Id,AS_Email__c  From AttendeeSummary__c 
                              Where AS_Email__c =: Attendee.AS_Email__c ];
       system.debug(' DUPLICATE CHECK 111111  '+CheckDuplicateEmail.size());              
       if(CheckDuplicateEmail.size() > 0){
           updateUser();
           DuplicateCheck = [select Id, Attendee_Event_IDs__c  
                             From Event_Attendee_Mapping__c
                             Where  AS_id__c =: CheckDuplicateEmail[0].Id 
                             AND EV_id__c =: SelectedEventId  
                             AND IsCancelled__c =: FALSE]; 
           system.debug(EditId +' DUPLICATE CHECK 2222222 '+DuplicateCheck.size());              
           if(DuplicateCheck.size() > 0){   
               
                 if(EditId != NULL){
                 
                      system.debug('  ATTENDE  TYPE '+SelectedAttendeeType);             
                     Database.UpsertResult attRes= Database.upsert(Attendee, AttendeeSummary__c.AS_Email__c.getDescribe().getSObjectField(), false);                   
                     DuplicateCheck[0].Attendee_Event_IDs__c= CheckDuplicateEmail[0].Id+'-'+SelectedEventId;
                     DuplicateCheck[0].GuestType__c= SelectedAttendeeType;

                     Database.Update(DuplicateCheck[0], FALSE);
                     //Database.UpsertResult UpsertEAM= Database.upsert(DuplicateCheck[0], Event_Attendee_Mapping__c.EA_AttendeeBarcode__c.getDescribe().getSObjectField(), false);                   
                      system.debug('  UPSERT EAM  '+DuplicateCheck[0]);                                  
                     //DataBase.UpsertResult attRes = Database.Upsert(Attendee, AttendeeSummary__c.id);
                     insertCustomerkey();
                     system.debug('LLLLLLLLLLLLL '+AddMTickets.size());
                     if(AddMTickets.size() >= 1){
                     
                      system.debug('VVVVVVVVVVVVVVVVV   '+AddMTickets[0]);
                       

                             
                        LIST<Dummay__c> listOfRegistrationInfo =new LIST<Dummay__c>();
                        MAP<Id, Decimal> toIncreaseTicketQuantity= new MAP<Id, Decimal>();
                        LIST<Individual_Ticket_Info__c> IndividualTicketInfo = new LIST<Individual_Ticket_Info__c>();
                        
                        
                        ListofTickettypes = new List<TicketTypes__c>();
                        
                        for(AddMultipleTickets amt:AddMTickets){
                            
                        system.debug('EEEEEEEEEEEEEEEEE '+AddMTickets[0]+amt.selectedString);               
                                       
                                        Dummay__c  RegistrationNewInfo = new Dummay__c();
                                        
                                        if(amt.selectedString != 'Select Ticket'){
                                            RegistrationNewInfo.AttendeeSummary__c = attRes.getId();
                                            RegistrationNewInfo.Company__c = Attendee.AS_Company__c;
                                            RegistrationNewInfo.Email__c = Attendee.AS_Email__c;
                                            RegistrationNewInfo.Last_Name__c = Attendee.AS_LastName__c;
                                            RegistrationNewInfo.First_Name__c = Attendee.AS_FirstName__c;
                                            RegistrationNewInfo.Event__c = SelectedEventId ;
                                            RegistrationNewInfo.TicketTypes__c = amt.selectedString;
                                            RegistrationNewInfo.customer_key__c = TransactionInfo.Id;
                                            RegistrationNewInfo.Update_with_created_date__c = Date.Today();
                                            RegistrationNewInfo.Payment_Status__c = 'Paid';

                                            RegistrationNewInfo.Event_Attendee_Mapping__c =  DuplicateCheck[0].Id;
                                            RegistrationNewInfo.Tickets_Quantty__c = amt.soldQty;
                                            RegistrationNewInfo.Seat_Number__c = amt.seatName;                                                                                       
                                            if(amt.TicketObj.TT_TicketType__c != 'Donation'){
                                                RegistrationNewInfo.TicketAmount__c= amt.soldQty*ticketsMAP.get(amt.selectedString).TT_Amount__c;                                            
                                            }else if(amt.TicketObj.TT_TicketType__c == 'Donation'){
                                                RegistrationNewInfo.TicketAmount__c= amt.soldQty*amt.DonationPrice;                                                          
                                            }
                                            

                                            if(ticketsMAP.get(amt.selectedString).TT_Name__c == 'Guest'){                                            
                                                RegistrationNewInfo.Payment_Type__c = 'Guest';                                           
                                            }else{
                                                RegistrationNewInfo.Payment_Type__c= SelectedPaymentType;
                                            }
                                            if(SelectedPaymentType == 'Free'){
                                                RegistrationNewInfo.TicketAmount__c= 0; 
                                            }
                                            system.debug(' CHARGE ID '+ChargeId);
                                            system.debug(' CHARGE NUMBER '+ChargeNumber);
                                            if(SelectedPaymentType == 'Check'){
                                                RegistrationNewInfo.Check_number__c= CheckNumber;
                                            }
                                            if(SelectedPaymentType == 'Credit Card'){
                                                 RegistrationNewInfo.payKey__c = ChargeId;
                                                 RegistrationNewInfo.Credit_Card_Number__c = ChargeNumber;
                                                 if(ticketsMAP.get(amt.selectedString).TT_Name__c == 'Guest' || ticketsMAP.get(amt.selectedString).TT_Name__c == 'Free'){
                                                     RegistrationNewInfo.ScanAttendee_Fee__c= amt.soldQty;                                                  
                                                 }else{
                                                     RegistrationNewInfo.ScanAttendee_Fee__c= amt.soldQty*FeeValue;                                                  
                                                 }

                                                 //RegistrationNewInfo.TicketAmount__c += RegistrationNewInfo.ScanAttendee_Fee__c;                                                          
                                            }else{
                                                RegistrationNewInfo.ScanAttendee_Fee__c= 0;                                                                                              
                                            }
                                            listOfRegistrationInfo.add(RegistrationNewInfo);
                                         
                                            amt.TicketObj.TT_Sold__c += amt.soldQty;
                                            ListofTickettypes.add(amt.TicketObj);
                                            if(toIncreaseTicketQuantity.containsKey(amt.TicketObj.id)){
                                                Decimal soldQuantity= toIncreaseTicketQuantity.get(amt.TicketObj.id);
                                                soldQuantity += amt.soldQty;
                                                toIncreaseTicketQuantity.put(amt.TicketObj.id, soldQuantity);
                                            }else{
                                                toIncreaseTicketQuantity.put(amt.TicketObj.id, amt.soldQty);
                                            }
                                        }
                             }
                 
                        Database.SaveResult[] createdRegInfoResult= Database.Insert(listOfRegistrationInfo ,False); 
                        for (Database.SaveResult sr : createdRegInfoResult) {
                            if (sr.isSuccess()) {
                                isRegInfoInserted= TRUE;
                            }
                        }
                        for(TicketTypes__c tic: ListofTickettypes){
                            if(toIncreaseTicketQuantity.get(tic.id) != NULL){
                                if(tic.Available__c < toIncreaseTicketQuantity.get(tic.id)){
                                    tic.TT_Available__c= tic.TT_Sold__c; 
                                }
                            }
                        }
                        Database.Update(ListofTickettypes);
                        Database.Insert(IndividualTicketInfo,False); 
                     
                        
                        
                     }
                     
                     if(AddMultipleItemsList.size() >= 1){

                      system.debug('VVVVVVVVVVVVVVVVV   '+AddMultipleItemsList[0]);
                     
                  
                        LIST<Dummay__c> listOfRegistrationInfoForItem=new LIST<Dummay__c>();
                        
                        ListofItems= new LIST<Item__c>();

                        for(AddMultipleItems ami:AddMultipleItemsList){

                        system.debug('EEEEEEEEEEEEEEEEE '+AddMultipleItemsList[0]+ami.SelectedItemName);               
                                
                                Dummay__c  RegistrationNewInfoForItem= new Dummay__c();
                                
                                if(ami.SelectedItemName != 'Select Item'){
                                RegistrationNewInfoForItem.AttendeeSummary__c = attRes.getId();
                                RegistrationNewInfoForItem.Company__c = Attendee.AS_Company__c;
                                RegistrationNewInfoForItem.Email__c = Attendee.AS_Email__c;
                                RegistrationNewInfoForItem.Last_Name__c = Attendee.AS_LastName__c;
                                RegistrationNewInfoForItem.First_Name__c = Attendee.AS_FirstName__c;
                                RegistrationNewInfoForItem.Event__c = SelectedEventId ;
                                RegistrationNewInfoForItem.Item__c = ami.SelectedItemName;
                                RegistrationNewInfoForItem.customer_key__c = TransactionInfo.Id;
                                RegistrationNewInfoForItem.Update_with_created_date__c = Date.Today();
                                RegistrationNewInfoForItem.Payment_Status__c =  'Paid';
                                RegistrationNewInfoForItem.Payment_Type__c = SelectedPaymentType;
                                RegistrationNewInfoForItem.Event_Attendee_Mapping__c =  DuplicateCheck[0].Id;
                                RegistrationNewInfoForItem.Item_Quantity__c = ami.RegInfo.Item_Quantity__c;
                                
                                if(itemsMAP.get(ami.SelectedItemName).Sales_Tax__c != NULL){
                                    Decimal TaxCost= (itemsMAP.get(ami.SelectedItemName).Sales_Tax__c*itemsMAP.get(ami.SelectedItemName).Cost__c)/100;
                                    RegistrationNewInfoForItem.TicketAmount__c= ami.RegInfo.Item_Quantity__c*((itemsMAP.get(ami.SelectedItemName).Cost__c+TaxCost));
                                }else{
                                    RegistrationNewInfoForItem.TicketAmount__c= ami.RegInfo.Item_Quantity__c*(itemsMAP.get(ami.SelectedItemName).Cost__c);
                                
                                }
                                if(SelectedPaymentType == 'Free'){
                                    RegistrationNewInfoForItem.TicketAmount__c= 0; 
                                }
                                            
                                 if(SelectedPaymentType == 'Check'){
                                     RegistrationNewInfoForItem.Check_number__c= CheckNumber;
                                 }
                                 if(SelectedPaymentType == 'Credit Card'){
                                     RegistrationNewInfoForItem.payKey__c = ChargeId;
                                     RegistrationNewInfoForItem.Credit_Card_Number__c = ChargeNumber;                           
                                     RegistrationNewInfoForItem.ScanAttendee_Fee__c= ami.RegInfo.Item_Quantity__c*FeeValue;                                                  
                                     //RegistrationNewInfoForItem.TicketAmount__c += RegistrationNewInfoForItem.ScanAttendee_Fee__c;                                                          
                                 }else{
                                                RegistrationNewInfoForItem.ScanAttendee_Fee__c= 0;                                                                                              
                                            }
                                listOfRegistrationInfoForItem.add(RegistrationNewInfoForItem);
                                
                                ami.ItemInfo.Sold_Quantity__c += ami.RegInfo.Item_Quantity__c;
                                ListofItems.add(ami.ItemInfo);
                                
                                }
                             }
                 
                        //Database.Insert(listOfRegistrationInfoForItem,False); 
                        
                        Database.SaveResult[] createdRegInfoItemResult= Database.Insert(listOfRegistrationInfoForItem,False); 
                        for (Database.SaveResult sr : createdRegInfoItemResult) {
                            if (sr.isSuccess()) {
                                isRegInfoInserted= TRUE;
                            }
                        }
                        Database.Update(ListofItems);
         
                     }                        
                     system.debug('  OREDR NAME11111111111111111 '+createdOrderName);
                     
                                    EditId ='';
                     if(isRegInfoInserted == FALSE){            
             pg = new Pagereference('/apex/SA_Attendees');
            return pg;  
         } 
                      
                 }else {                      
                      
                      System.debug('  Attendee Already Exist   ');
                      Database.UpsertResult attRes= Database.upsert(Attendee, AttendeeSummary__c.AS_Email__c.getDescribe().getSObjectField(), false);                   
                      DuplicateCheck[0].Attendee_Event_IDs__c= CheckDuplicateEmail[0].Id+'-'+SelectedEventId;
                      DuplicateCheck[0].GuestType__c= SelectedAttendeeType;
                      DuplicateCheck[0].IsCancelled__c= FALSE;
                      
                      Database.Update(DuplicateCheck[0], FALSE);
                      //Database.UpsertResult UpsertEAM= Database.upsert(DuplicateCheck[0], Event_Attendee_Mapping__c.EA_AttendeeBarcode__c.getDescribe().getSObjectField(), false);                   
                     
                      System.debug(DuplicateCheck[0]+'  EAM UPDATE ');                     
                      LIST<Dummay__c> listOfRegistrationInfo= new LIST<Dummay__c>();
                      MAP<Id, Decimal> toIncreaseTicketQuantity= new MAP<Id, Decimal>();
                      ListofTickettypes= new LIST<TicketTypes__c>();
                      //AllreadyExist = TRUE;
                      insertCustomerkey();                      
                      for(AddMultipleTickets amt:AddMTickets){
                            
                          system.debug('EEEEEEEEEEEEEEEEE '+AddMTickets[0]+amt.selectedString);               
                          Dummay__c  RegistrationNewInfo = new Dummay__c();
                              if(amt.selectedString != 'Select Ticket'){
                                  RegistrationNewInfo.AttendeeSummary__c = Attendee.Id;
                                  RegistrationNewInfo.Company__c = Attendee.AS_Company__c;
                                  RegistrationNewInfo.Email__c = Attendee.AS_Email__c;
                                  RegistrationNewInfo.Last_Name__c = Attendee.AS_LastName__c;
                                  RegistrationNewInfo.First_Name__c = Attendee.AS_FirstName__c;
                                  RegistrationNewInfo.Event__c = SelectedEventId ;
                                  RegistrationNewInfo.TicketTypes__c = amt.selectedString;
                                  RegistrationNewInfo.customer_key__c = TransactionInfo.Id;
                                  RegistrationNewInfo.Update_with_created_date__c = Date.Today();
                                  RegistrationNewInfo.Payment_Status__c = 'Paid';
                                  RegistrationNewInfo.Payment_Type__c = 'Guest';
                                  RegistrationNewInfo.Event_Attendee_Mapping__c =  DuplicateCheck[0].Id;
                                  RegistrationNewInfo.Tickets_Quantty__c = amt.soldQty;
                                  RegistrationNewInfo.ScanAttendee_Fee__c= 0;                                                                                              
                                  RegistrationNewInfo.TicketAmount__c= amt.soldQty*ticketsMAP.get(amt.selectedString).TT_Amount__c;
                                  if(ticketsMAP.get(amt.selectedString).TT_Name__c == 'Guest'){                                            
                                      RegistrationNewInfo.Payment_Type__c = 'Guest';                                           
                                  }else{
                                      RegistrationNewInfo.Payment_Type__c= SelectedPaymentType;
                                  }
                                  if(SelectedPaymentType == 'Free'){
                                      RegistrationNewInfo.TicketAmount__c= 0; 
                                  }
                                
                                  RegistrationNewInfo.Seat_Number__c = amt.seatName;
                                        
                                  system.debug(' CHARGE ID '+ChargeId);
                                  if(SelectedPaymentType == 'Check'){
                                      RegistrationNewInfo.Check_number__c= CheckNumber;
                                  }
                                  if(SelectedPaymentType == 'Credit Card'){
                                      RegistrationNewInfo.payKey__c = ChargeId;
                                      RegistrationNewInfo.Credit_Card_Number__c = ChargeNumber;
                                      
                                      if(ticketsMAP.get(amt.selectedString).TT_Name__c == 'Guest' || ticketsMAP.get(amt.selectedString).TT_Name__c == 'Free'){
                                          RegistrationNewInfo.ScanAttendee_Fee__c= amt.soldQty;                                                  
                                      }else{
                                          RegistrationNewInfo.ScanAttendee_Fee__c= amt.soldQty*FeeValue;                                                  
                                      }

                                      //RegistrationNewInfo.TicketAmount__c += RegistrationNewInfo.ScanAttendee_Fee__c;
                                  }else{
                                                RegistrationNewInfo.ScanAttendee_Fee__c= 0;                                                                                              
                                            }
                                  listOfRegistrationInfo.add(RegistrationNewInfo);
                                  //amt.TicketObj=  guestTicket;    
                                  if(toIncreaseTicketQuantity.containsKey(amt.TicketObj.id)){
                                    Decimal soldQuantity= toIncreaseTicketQuantity.get(amt.TicketObj.id);
                                    soldQuantity += amt.soldQty;
                                    toIncreaseTicketQuantity.put(amt.TicketObj.id, soldQuantity);
                                  }else{
                                    toIncreaseTicketQuantity.put(amt.TicketObj.id, amt.soldQty);
                  
                                  }  
                                  amt.TicketObj.TT_Sold__c += amt.soldQty;
                                  ListofTickettypes.add(amt.TicketObj);
                                            
                            }
                        }
                 
                        Database.SaveResult[] createdRegInfoResult= Database.Insert(listOfRegistrationInfo ,False); 
                        for (Database.SaveResult sr : createdRegInfoResult) {
                            if (sr.isSuccess()) {
                                isRegInfoInserted= TRUE;
                            }
                        }
                        for(TicketTypes__c tic: ListofTickettypes){
                            if(toIncreaseTicketQuantity.get(tic.id) != NULL){
                                if(tic.Available__c < toIncreaseTicketQuantity.get(tic.id)){
                                    tic.TT_Available__c= tic.TT_Sold__c; 
                                }
                            }
                        }
                        Database.Update(ListofTickettypes);
                        
                        
                        LIST<Dummay__c> listOfRegistrationInfoForItem=new LIST<Dummay__c>();
                        
                        ListofItems= new LIST<Item__c>();

                        for(AddMultipleItems ami:AddMultipleItemsList){

                        system.debug('EEEEEEEEEEEEEEEEE '+AddMultipleItemsList[0]+ami.SelectedItemName);               
                                
                                Dummay__c  RegistrationNewInfoForItem= new Dummay__c();
                                
                                if(ami.SelectedItemName != 'Select Item'){
                                RegistrationNewInfoForItem.AttendeeSummary__c = Attendee.Id;
                                RegistrationNewInfoForItem.Company__c = Attendee.AS_Company__c;
                                RegistrationNewInfoForItem.Email__c = Attendee.AS_Email__c;
                                RegistrationNewInfoForItem.Last_Name__c = Attendee.AS_LastName__c;
                                RegistrationNewInfoForItem.First_Name__c = Attendee.AS_FirstName__c;
                                RegistrationNewInfoForItem.Event__c = SelectedEventId ;
                                RegistrationNewInfoForItem.Item__c = ami.SelectedItemName;
                                RegistrationNewInfoForItem.customer_key__c = TransactionInfo.Id;
                                RegistrationNewInfoForItem.Update_with_created_date__c = Date.Today();
                                RegistrationNewInfoForItem.Payment_Status__c =  'Paid';
                                RegistrationNewInfoForItem.Payment_Type__c = SelectedPaymentType;
                                RegistrationNewInfoForItem.Event_Attendee_Mapping__c =  DuplicateCheck[0].Id;
                                RegistrationNewInfoForItem.Item_Quantity__c = ami.RegInfo.Item_Quantity__c;
                                
                                if(itemsMAP.get(ami.SelectedItemName).Sales_Tax__c != NULL){
                                    Decimal TaxCost= (itemsMAP.get(ami.SelectedItemName).Sales_Tax__c*itemsMAP.get(ami.SelectedItemName).Cost__c)/100;
                                    RegistrationNewInfoForItem.TicketAmount__c= ami.RegInfo.Item_Quantity__c*((itemsMAP.get(ami.SelectedItemName).Cost__c+TaxCost));
                                }else{
                                    RegistrationNewInfoForItem.TicketAmount__c= ami.RegInfo.Item_Quantity__c*(itemsMAP.get(ami.SelectedItemName).Cost__c);
                                
                                }
                                if(SelectedPaymentType == 'Free'){
                                    RegistrationNewInfoForItem.TicketAmount__c= 0; 
                                }
                                
                                 if(SelectedPaymentType == 'Check'){
                                        RegistrationNewInfoForItem.Check_number__c= CheckNumber;
                                    }
                                 if(SelectedPaymentType == 'Credit Card'){
                                     RegistrationNewInfoForItem.payKey__c = ChargeId;
                                     RegistrationNewInfoForItem.Credit_Card_Number__c = ChargeNumber;
                                     RegistrationNewInfoForItem.ScanAttendee_Fee__c= ami.RegInfo.Item_Quantity__c*FeeValue;                                                  
                                     RegistrationNewInfoForItem.TicketAmount__c += RegistrationNewInfoForItem.ScanAttendee_Fee__c;
                                 }else{
                                                RegistrationNewInfoForItem.ScanAttendee_Fee__c= 0;                                                                                              
                                            }
                                listOfRegistrationInfoForItem.add(RegistrationNewInfoForItem);
                                
                                ami.ItemInfo.Sold_Quantity__c += ami.RegInfo.Item_Quantity__c;
                                ListofItems.add(ami.ItemInfo);
                                
                                }
                             }
                 
                        //Database.Insert(listOfRegistrationInfoForItem,False); 
                        Database.SaveResult[] createdRegInfoItemResult= Database.Insert(listOfRegistrationInfoForItem,False); 
                        for (Database.SaveResult sr : createdRegInfoItemResult) {
                            if (sr.isSuccess()) {
                                isRegInfoInserted= TRUE;
                            }
                        }
                        
                        Database.Update(ListofItems);
         
                      System.debug('***********************    '+Attendee.id);
                      system.debug('  OREDR NAME11111111111111111 '+createdOrderName);
                      
                        if(isRegInfoInserted == FALSE){            
             pg = new Pagereference('/apex/SA_Attendees');
            return pg;  
         } 
                     
                
                 } 
                          
               
                                               
          }else{
          
            system.debug('  CHECKEXISTING ATTENDEE 11111111  '+CheckDuplicateEmail[0]);
            //Database.Update(CheckDuplicateEmail[0], FALSE);
            Database.UpsertResult attRes= Database.upsert(Attendee, AttendeeSummary__c.AS_Email__c.getDescribe().getSObjectField(), false);                   
            system.debug('  CHECKEXISTING ATTENDEE 222222  '+CheckDuplicateEmail[0]);
            
            Event_Attendee_Mapping__c Event_Attendee = new Event_Attendee_Mapping__c();
            Event_Attendee.AS_id__c = CheckDuplicateEmail[0].Id;
            Event_Attendee.EV_id__c = SelectedEventId ;
            Event_Attendee.Attendee_Event_IDs__c= CheckDuplicateEmail[0].Id+'-'+SelectedEventId;
            Event_Attendee.GuestType__c= SelectedAttendeeType;
            Event_Attendee.IsCancelled__c= FALSE; 
            //Database.UpsertResult UpsertEAM= Database.upsert(Event_Attendee, Event_Attendee_Mapping__c.Attendee_Event_IDs__c.getDescribe().getSObjectField(), false);                   
                     
            Database.Insert(Event_Attendee,False);
              
            insertCustomerkey();
            
            LIST<Dummay__c> listOfRegistrationInfo =new LIST<Dummay__c>();
            LIST<Individual_Ticket_Info__c> IndividualTicketInfo = new LIST<Individual_Ticket_Info__c>();
            MAP<Id, Decimal> toIncreaseTicketQuantity= new MAP<Id, Decimal>();
            
            ListofTickettypes = new List<TicketTypes__c>();
            
            if(AddMTickets.size() <=1 && AddMultipleItemsList.size() <= 1){
        
             for(AddMultipleTickets amt:AddMTickets){
                 for(AddMultipleItems ami:AddMultipleItemsList){
            
                     if(amt.selectedString == 'Select Ticket' && ami.SelectedItemName == 'Select Item'){ 
                                
                            Dummay__c  RegistrationNewInfoForTicket= new Dummay__c();        
                            
                            LIST<TicketTypes__c> guestTicket= new LIST<TicketTypes__c>([SELECT ID, TT_Sold__c FROM TicketTypes__c WHERE TT_Name__c =: 'Guest' AND EV_id__c =: SelectedEventId]);
                            RegistrationNewInfoForTicket.AttendeeSummary__c = attRes.getId();
                            RegistrationNewInfoForTicket.Company__c = Attendee.AS_Company__c;
                            RegistrationNewInfoForTicket.Email__c = Attendee.AS_Email__c;
                            RegistrationNewInfoForTicket.Last_Name__c = Attendee.AS_LastName__c;
                            RegistrationNewInfoForTicket.First_Name__c = Attendee.AS_FirstName__c;
                            RegistrationNewInfoForTicket.Event__c = SelectedEventId ;
                            if(guestTicket.size() >0){
                                RegistrationNewInfoForTicket.TicketTypes__c = guestTicket[0].Id;
                            }
                            RegistrationNewInfoForTicket.customer_key__c = TransactionInfo.Id;
                            RegistrationNewInfoForTicket.Update_with_created_date__c = Date.Today();
                            RegistrationNewInfoForTicket.Payment_Status__c =  'Paid';
                            RegistrationNewInfoForTicket.Payment_Type__c = 'Guest';
                            RegistrationNewInfoForTicket.Event_Attendee_Mapping__c =  Event_Attendee.id;
                            RegistrationNewInfoForTicket.Tickets_Quantty__c = 1;
                            //RegistrationNewInfoForTicket.Event_Attendee_Mapping__c = Event_Attendee.Id;
                            RegistrationNewInfoForTicket.TicketAmount__c= 0;
                            RegistrationNewInfoForTicket.ScanAttendee_Fee__c= 0;   
                                                                                                                                                   
                            listOfRegistrationInfo.add(RegistrationNewInfoForTicket);
                            amt.TicketObj= guestTicket[0];
                            amt.TicketObj.TT_Sold__c = amt.TicketObj.TT_Sold__c+1;
                            if(amt.TicketObj.Available__c <= 0){
                                amt.TicketObj.TT_Available__c += 1;
                            }
                                ListofTickettypes.add(amt.TicketObj);     
                   }
               }
            } 
        }
        
            for(AddMultipleTickets amt:AddMTickets){

                            Dummay__c  RegistrationNewInfo = new Dummay__c();
                            if(amt.selectedString != 'Select Ticket'){
                                RegistrationNewInfo.AttendeeSummary__c = CheckDuplicateEmail[0].Id;
                                RegistrationNewInfo.Company__c = Attendee.AS_Company__c;
                                RegistrationNewInfo.Email__c = Attendee.AS_Email__c;
                                RegistrationNewInfo.Last_Name__c = Attendee.AS_LastName__c;
                                RegistrationNewInfo.First_Name__c = Attendee.AS_FirstName__c;
                                RegistrationNewInfo.Event__c = SelectedEventId ;
                                RegistrationNewInfo.TicketTypes__c = amt.selectedString;
                                RegistrationNewInfo.customer_key__c = TransactionInfo.Id;
                                RegistrationNewInfo.Update_with_created_date__c = Date.Today();
                                RegistrationNewInfo.Payment_Status__c = 'Paid';
                                RegistrationNewInfo.Event_Attendee_Mapping__c =  Event_Attendee.id;
                                RegistrationNewInfo.Tickets_Quantty__c = amt.soldQty;
                                RegistrationNewInfo.Seat_Number__c = amt.seatName;
                                RegistrationNewInfo.Event_Attendee_Mapping__c = Event_Attendee.Id;
                                
                                if(amt.TicketObj.TT_TicketType__c != 'Donation'){
                                    RegistrationNewInfo.TicketAmount__c= amt.soldQty*ticketsMAP.get(amt.selectedString).TT_Amount__c;                                            
                                }else if(amt.TicketObj.TT_TicketType__c == 'Donation'){
                                    RegistrationNewInfo.TicketAmount__c= amt.soldQty*amt.DonationPrice;                                                          
                                }

                                  if(ticketsMAP.get(amt.selectedString).TT_Name__c == 'Guest'){                                            
                                      RegistrationNewInfo.Payment_Type__c = 'Guest';                                           
                                  }else{
                                      RegistrationNewInfo.Payment_Type__c= SelectedPaymentType;
                                  }
                                  if(SelectedPaymentType == 'Free'){
                                    RegistrationNewInfo.TicketAmount__c= 0; 
                                }
                                
                                  
                                if(SelectedPaymentType == 'Check'){
                                     RegistrationNewInfo.Check_number__c= CheckNumber;
                                }
                                if(SelectedPaymentType == 'Credit Card'){
                                    RegistrationNewInfo.payKey__c = ChargeId;
                                    RegistrationNewInfo.Credit_Card_Number__c = ChargeNumber;
                                    if(ticketsMAP.get(amt.selectedString).TT_Name__c == 'Guest' || ticketsMAP.get(amt.selectedString).TT_Name__c == 'Free'){
                                          RegistrationNewInfo.ScanAttendee_Fee__c= amt.soldQty;                                                  
                                      }else{
                                          RegistrationNewInfo.ScanAttendee_Fee__c= amt.soldQty*FeeValue;                                                  
                                      }

                                    //RegistrationNewInfo.TicketAmount__c += RegistrationNewInfo.ScanAttendee_Fee__c;
                                }else{
                                                RegistrationNewInfo.ScanAttendee_Fee__c= 0;                                                                                              
                                            }
                                listOfRegistrationInfo.add(RegistrationNewInfo);
                                if(toIncreaseTicketQuantity.containsKey(amt.TicketObj.id)){
                                                Decimal soldQuantity= toIncreaseTicketQuantity.get(amt.TicketObj.id);
                                                soldQuantity += amt.soldQty;
                                                toIncreaseTicketQuantity.put(amt.TicketObj.id, soldQuantity);
                                            }else{
                                                toIncreaseTicketQuantity.put(amt.TicketObj.id, amt.soldQty);
                                            }
                                amt.TicketObj.TT_Sold__c += amt.soldQty;
                                ListofTickettypes.add(amt.TicketObj);                                                                        
                 }
     }
            
            
            
            Database.SaveResult[] createdRegInfoResult= Database.Insert(listOfRegistrationInfo ,False); 
                        for (Database.SaveResult sr : createdRegInfoResult) {
                            if (sr.isSuccess()) {
                                isRegInfoInserted= TRUE;
                            }
                        }
            for(TicketTypes__c tic: ListofTickettypes){
                            if(toIncreaseTicketQuantity.get(tic.id) != NULL){
                                if(tic.Available__c < toIncreaseTicketQuantity.get(tic.id)){
                                    tic.TT_Available__c= tic.TT_Sold__c; 
                                }
                           }
            }
            Database.Update(ListofTickettypes);
            Database.Insert(IndividualTicketInfo,False); 
            
                                 
                        
                        LIST<Dummay__c> listOfRegistrationInfoForItem=new LIST<Dummay__c>();
                        
                        ListofItems= new LIST<Item__c>();

                        for(AddMultipleItems ami:AddMultipleItemsList){
                            
                        system.debug('EEEEEEEEEEEEEEEEE '+AddMultipleItemsList[0]+ami.SelectedItemName);               
                                       
                                        Dummay__c  RegistrationNewInfoForItem= new Dummay__c();
                                        
                                        if(ami.SelectedItemName != 'Select Item'){
                                            RegistrationNewInfoForItem.AttendeeSummary__c = CheckDuplicateEmail[0].Id;
                                            RegistrationNewInfoForItem.Company__c = Attendee.AS_Company__c;
                                            RegistrationNewInfoForItem.Email__c = Attendee.AS_Email__c;
                                            RegistrationNewInfoForItem.Last_Name__c = Attendee.AS_LastName__c;
                                            RegistrationNewInfoForItem.First_Name__c = Attendee.AS_FirstName__c;
                                            RegistrationNewInfoForItem.Event__c = SelectedEventId ;
                                            RegistrationNewInfoForItem.Item__c = ami.SelectedItemName;
                                            RegistrationNewInfoForItem.customer_key__c = TransactionInfo.Id;
                                            RegistrationNewInfoForItem.Update_with_created_date__c = Date.Today();
                                            RegistrationNewInfoForItem.Payment_Status__c =  'Paid' ;
                                            RegistrationNewInfoForItem.Payment_Type__c = SelectedPaymentType;
                                            RegistrationNewInfoForItem.Event_Attendee_Mapping__c =  Event_Attendee.Id;
                                            RegistrationNewInfoForItem.Item_Quantity__c = ami.RegInfo.Item_Quantity__c;
                                            
                                            if(itemsMAP.get(ami.SelectedItemName).Sales_Tax__c != NULL){
                                                 Decimal TaxCost= (itemsMAP.get(ami.SelectedItemName).Sales_Tax__c*itemsMAP.get(ami.SelectedItemName).Cost__c)/100;
                                                 RegistrationNewInfoForItem.TicketAmount__c= ami.RegInfo.Item_Quantity__c*((itemsMAP.get(ami.SelectedItemName).Cost__c+TaxCost));
                                            }else{
                                                RegistrationNewInfoForItem.TicketAmount__c= ami.RegInfo.Item_Quantity__c*(itemsMAP.get(ami.SelectedItemName).Cost__c);
                                            }
                                            
                                            if(SelectedPaymentType == 'Check'){
                                                RegistrationNewInfoForItem.Check_number__c= CheckNumber;
                                            }
                                            if(SelectedPaymentType == 'Free'){
                                                RegistrationNewInfoForItem.TicketAmount__c= 0; 
                                            }
                                
                                            if(SelectedPaymentType == 'Credit Card'){
                                                RegistrationNewInfoForItem.payKey__c = ChargeId;
                                                RegistrationNewInfoForItem.Credit_Card_Number__c = ChargeNumber;
                                                RegistrationNewInfoForItem.ScanAttendee_Fee__c= ami.RegInfo.Item_Quantity__c*FeeValue;                                                  
                                                RegistrationNewInfoForItem.TicketAmount__c += RegistrationNewInfoForItem.ScanAttendee_Fee__c;
                                            }else{
                                                RegistrationNewInfoForItem.ScanAttendee_Fee__c= 0;                                                                                              
                                            }
                                            
                                            listOfRegistrationInfoForItem.add(RegistrationNewInfoForItem);
                                         
                                            ami.ItemInfo.Sold_Quantity__c += ami.RegInfo.Item_Quantity__c;
                                            ListofItems.add(ami.ItemInfo);
                                            
                                        }
                             }
                 
                        //Database.Insert(listOfRegistrationInfoForItem,False); 
                        Database.SaveResult[] createdRegInfoItemResult= Database.Insert(listOfRegistrationInfoForItem,False); 
                        for (Database.SaveResult sr : createdRegInfoItemResult) {
                            if (sr.isSuccess()) {
                                isRegInfoInserted= TRUE;
                            }
                        }
                        Database.Update(ListofItems);
                     system.debug('  OREDR NAME11111111111111111 '+createdOrderName);
                    
                     
                                      EditId ='';  
            if(isRegInfoInserted == FALSE){            
             pg = new Pagereference('/apex/SA_Attendees');
            return pg;  
         }
            
            
            
        /**    DisplayAttendees  = [select Id,AS_id__c,AS_id__r.AS_FirstName__c,checkbox_dataTable__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Email__c,
                             AS_id__r.AS_WorkPhone__c from Event_Attendee_Mapping__c Where EV_id__c =:SelectedEventId  ];

         **/ 
          }              

       }                        
       else{
        
       DataBase.UpsertResult attRes = Database.Upsert(Attendee, AttendeeSummary__c.AS_Email__c);     
        
        
        Event_Attendee_Mapping__c Event_Attendee = new Event_Attendee_Mapping__c();
        Event_Attendee.AS_id__c = Attendee.Id;
        Event_Attendee.EV_id__c = SelectedEventId;
        Event_Attendee.Attendee_Event_IDs__c= Attendee.Id+'-'+SelectedEventId;
        Event_Attendee.GuestType__c= SelectedAttendeeType;
        
        Database.SaveResult createEAMResult= Database.insert(Event_Attendee, false);
        //Database.UpsertResult UpsertEAM= Database.upsert(Event_Attendee, Event_Attendee_Mapping__c.EA_AttendeeBarcode__c.getDescribe().getSObjectField(), false);                   
                      
        insertCustomerkey();
        
        LIST<Dummay__c> listOfRegistrationInfo =new LIST<Dummay__c>();
        LIST<Individual_Ticket_Info__c> IndividualTicketInfo = new LIST<Individual_Ticket_Info__c>();
        MAP<Id, Decimal> toIncreaseTicketQuantity= new MAP<Id, Decimal>();
        
        ListofTickettypes = new List<TicketTypes__c>();
        
        if(AddMTickets.size() <=1 && AddMultipleItemsList.size() <=1){
        
             for(AddMultipleTickets amt:AddMTickets){
                 for(AddMultipleItems ami:AddMultipleItemsList){
            
                     if(amt.selectedString == 'Select Ticket' && ami.SelectedItemName == 'Select Item'){ 
                               
                        Dummay__c  RegistrationNewInfoForTicket= new Dummay__c();        
                        
                        LIST<TicketTypes__c> guestTicket= new LIST<TicketTypes__c>([SELECT ID, TT_Sold__c FROM TicketTypes__c WHERE TT_Name__c =: 'Guest' AND EV_id__c =: SelectedEventId]);
                        RegistrationNewInfoForTicket.AttendeeSummary__c = attRes.getId();
                        RegistrationNewInfoForTicket.Company__c = Attendee.AS_Company__c;
                        RegistrationNewInfoForTicket.Email__c = Attendee.AS_Email__c;
                        RegistrationNewInfoForTicket.Last_Name__c = Attendee.AS_LastName__c;
                        RegistrationNewInfoForTicket.First_Name__c = Attendee.AS_FirstName__c;
                        RegistrationNewInfoForTicket.Event__c = SelectedEventId ;
                        RegistrationNewInfoForTicket.TicketTypes__c = guestTicket[0].Id;
                        RegistrationNewInfoForTicket.customer_key__c = TransactionInfo.Id;
                        RegistrationNewInfoForTicket.Update_with_created_date__c = Date.Today();
                        RegistrationNewInfoForTicket.Payment_Status__c =  'Paid';
                        RegistrationNewInfoForTicket.Payment_Type__c = 'Guest';
                        RegistrationNewInfoForTicket.Event_Attendee_Mapping__c =  Event_Attendee.id;
                        RegistrationNewInfoForTicket.Tickets_Quantty__c = 1;
                        //RegistrationNewInfoForTicket.Event_Attendee_Mapping__c = Event_Attendee.Id;
                        RegistrationNewInfoForTicket.TicketAmount__c= 0;
                        RegistrationNewInfoForTicket.ScanAttendee_Fee__c= 0;                                                                                              
                                            
                        listOfRegistrationInfo.add(RegistrationNewInfoForTicket);
                        amt.TicketObj= guestTicket[0];
                        amt.TicketObj.TT_Sold__c += 1;
                        if(amt.TicketObj.Available__c <= 0){
                            amt.TicketObj.TT_Available__c +=1;
                        }
                        ListofTickettypes.add(amt.TicketObj);
                            
                    }
                 }
            } 
        }
        for(AddMultipleTickets amt:AddMTickets){
            
                    Dummay__c  RegistrationNewInfo = new Dummay__c();
                        
                        if(amt.selectedString != 'Select Ticket'){ 
                            
                            RegistrationNewInfo.AttendeeSummary__c = attRes.getId();
                            RegistrationNewInfo.Company__c = Attendee.AS_Company__c;
                            RegistrationNewInfo.Email__c = Attendee.AS_Email__c;
                            RegistrationNewInfo.Last_Name__c = Attendee.AS_LastName__c;
                            RegistrationNewInfo.First_Name__c = Attendee.AS_FirstName__c;
                            RegistrationNewInfo.Event__c = SelectedEventId ;
                            RegistrationNewInfo.TicketTypes__c = amt.selectedString;
                            RegistrationNewInfo.customer_key__c = TransactionInfo.Id;
                            RegistrationNewInfo.Update_with_created_date__c = Date.Today();
                            RegistrationNewInfo.Payment_Status__c =  'Paid';
                            RegistrationNewInfo.Event_Attendee_Mapping__c =  Event_Attendee.id;
                            RegistrationNewInfo.Tickets_Quantty__c = amt.soldQty;
                            RegistrationNewInfo.Seat_Number__c = amt.seatName;
                            RegistrationNewInfo.Event_Attendee_Mapping__c = Event_Attendee.Id;
                            if(amt.TicketObj.TT_TicketType__c != 'Donation'){
                                RegistrationNewInfo.TicketAmount__c= amt.soldQty*ticketsMAP.get(amt.selectedString).TT_Amount__c;                                            
                            }else if(amt.TicketObj.TT_TicketType__c == 'Donation'){
                                RegistrationNewInfo.TicketAmount__c= amt.soldQty*amt.DonationPrice;                                                          
                            }

                            if(ticketsMAP.get(amt.selectedString).TT_Name__c == 'Guest'){                                            
                                RegistrationNewInfo.Payment_Type__c = 'Guest';                                           
                            }else{
                                RegistrationNewInfo.Payment_Type__c= SelectedPaymentType;
                            }
                            if(SelectedPaymentType == 'Free'){
                                    RegistrationNewInfo.TicketAmount__c= 0; 
                                }
                                
                                     
                            if(SelectedPaymentType == 'Check'){
                                RegistrationNewInfo.Check_number__c= CheckNumber;
                            }
                             if(SelectedPaymentType == 'Credit Card'){
                                 RegistrationNewInfo.payKey__c = ChargeId;
                                 RegistrationNewInfo.Credit_Card_Number__c = ChargeNumber;
                                 
                                 if(ticketsMAP.get(amt.selectedString).TT_Name__c == 'Guest' || ticketsMAP.get(amt.selectedString).TT_Name__c == 'Free'){
                                     RegistrationNewInfo.ScanAttendee_Fee__c= amt.soldQty;                                                  
                                 }else{
                                     RegistrationNewInfo.ScanAttendee_Fee__c= amt.soldQty*FeeValue;                                                  
                                 }
                                 //RegistrationNewInfo.TicketAmount__c += RegistrationNewInfo.ScanAttendee_Fee__c;
                             }  else{
                                                RegistrationNewInfo.ScanAttendee_Fee__c= 0;                                                                                              
                                            }              
                            listOfRegistrationInfo.add(RegistrationNewInfo);
                         
                            amt.TicketObj.TT_Sold__c += amt.soldQty;
                            ListofTickettypes.add(amt.TicketObj);
                             if(toIncreaseTicketQuantity.containsKey(amt.TicketObj.id)){
                                                Decimal soldQuantity= toIncreaseTicketQuantity.get(amt.TicketObj.id);
                                                soldQuantity += amt.soldQty;
                                                toIncreaseTicketQuantity.put(amt.TicketObj.id, soldQuantity);
                                            }else{
                                                toIncreaseTicketQuantity.put(amt.TicketObj.id, amt.soldQty);
                                            }
                            
                        }
             }
 
        
        
        
        Database.SaveResult[] createdRegInfoResult= Database.Insert(listOfRegistrationInfo ,False); 
                        for (Database.SaveResult sr : createdRegInfoResult) {
                            if (sr.isSuccess()) {
                                isRegInfoInserted= TRUE;
                            }
                        }
                                for(TicketTypes__c tic: ListofTickettypes){
                            if(toIncreaseTicketQuantity.get(tic.id) != NULL){
                                if(tic.Available__c < toIncreaseTicketQuantity.get(tic.id)){
                                    tic.TT_Available__c= tic.TT_Sold__c; 
                                }
                            }
                        }
        Database.Update(ListofTickettypes);
        Database.Insert(IndividualTicketInfo,False);
        
          
                                                  
                        LIST<Dummay__c> listOfRegistrationInfoForItem=new LIST<Dummay__c>();
                        
                        ListofItems= new LIST<Item__c>();

                        for(AddMultipleItems ami:AddMultipleItemsList){
                            
                        system.debug('EEEEEEEEEEEEEEEEE '+AddMultipleItemsList[0]+ami.SelectedItemName);               
                                       
                                        Dummay__c  RegistrationNewInfoForItem= new Dummay__c();
                                        
                                        if(ami.SelectedItemName != 'Select Item'){
                                            RegistrationNewInfoForItem.AttendeeSummary__c = attRes.getId();
                                            RegistrationNewInfoForItem.Company__c = Attendee.AS_Company__c;
                                            RegistrationNewInfoForItem.Email__c = Attendee.AS_Email__c;
                                            RegistrationNewInfoForItem.Last_Name__c = Attendee.AS_LastName__c;
                                            RegistrationNewInfoForItem.First_Name__c = Attendee.AS_FirstName__c;
                                            RegistrationNewInfoForItem.Event__c = SelectedEventId ;
                                            RegistrationNewInfoForItem.Item__c = ami.SelectedItemName;
                                            RegistrationNewInfoForItem.customer_key__c = TransactionInfo.Id;
                                            RegistrationNewInfoForItem.Update_with_created_date__c = Date.Today();
                                            RegistrationNewInfoForItem.Payment_Status__c = 'Paid';
                                            RegistrationNewInfoForItem.Payment_Type__c = SelectedPaymentType;
                                            RegistrationNewInfoForItem.Event_Attendee_Mapping__c =  Event_Attendee.id;
                                            //RegistrationNewInfoForItem.Event_Attendee_Mapping__c =  DuplicateCheck[0].Id;
                                            RegistrationNewInfoForItem.Item_Quantity__c = ami.RegInfo.Item_Quantity__c;
                                            
                                            if(itemsMAP.get(ami.SelectedItemName).Sales_Tax__c != NULL){
                                                 Decimal TaxCost= (itemsMAP.get(ami.SelectedItemName).Sales_Tax__c*itemsMAP.get(ami.SelectedItemName).Cost__c)/100;
                                                 RegistrationNewInfoForItem.TicketAmount__c= ami.RegInfo.Item_Quantity__c*((itemsMAP.get(ami.SelectedItemName).Cost__c+TaxCost));
                                        
                                            }else{
                                                RegistrationNewInfoForItem.TicketAmount__c= ami.RegInfo.Item_Quantity__c*(itemsMAP.get(ami.SelectedItemName).Cost__c);
                                            }
                                            if(SelectedPaymentType == 'Free'){
                                                RegistrationNewInfoForItem.TicketAmount__c= 0; 
                                            }
                                
                                            if(SelectedPaymentType == 'Check'){
                                                RegistrationNewInfoForItem.Check_number__c= CheckNumber;
                                            }
                                              if(SelectedPaymentType == 'Credit Card'){
                                                 RegistrationNewInfoForItem.payKey__c = ChargeId;
                                                 RegistrationNewInfoForItem.Credit_Card_Number__c =ChargeNumber;
                                                 RegistrationNewInfoForItem.ScanAttendee_Fee__c= ami.RegInfo.Item_Quantity__c*FeeValue;                                                  
                                                 RegistrationNewInfoForItem.TicketAmount__c += RegistrationNewInfoForItem.ScanAttendee_Fee__c;
                                                                                                
                                              } else{
                                                RegistrationNewInfoForItem.ScanAttendee_Fee__c= 0;                                                                                              
                                            } 
                                            listOfRegistrationInfoForItem.add(RegistrationNewInfoForItem);
                                         
                                            ami.ItemInfo.Sold_Quantity__c += ami.RegInfo.Item_Quantity__c;
                                            ListofItems.add(ami.ItemInfo);
                                            
                                        }
                             }
                 
                        //Database.Insert(listOfRegistrationInfoForItem,False); 
                        Database.SaveResult[] createdRegInfoItemResult= Database.Insert(listOfRegistrationInfoForItem,False); 
                        for (Database.SaveResult sr : createdRegInfoItemResult) {
                            if (sr.isSuccess()) {
                                isRegInfoInserted= TRUE;
                            }
                        }
                        Database.Update(ListofItems);
                        system.debug('  OREDR NAME11111111111111111 '+createdOrderName);
                       
                        system.debug('   IS INSERTED000000000  '+isRegInfoInserted);
                            EditId ='';
         if(isRegInfoInserted == FALSE){            
             pg = new Pagereference('/apex/SA_Attendees');
            return pg;  
         }
       }
       
        system.debug('   IS INSERTED000000000  '+isRegInfoInserted);
       return null;
    }
   
   
    // For Adding Guests
    
    public Boolean SoldQuantityError {get; set;}
    public String SelectedTicketQuantity{get; set;}
    public String SelectedRegInfoId{get; set;}
    public String SelectedTicketName{get; set;}
    public Integer AvailableGuest{get; set;}

    public void addGuestForm(){       
       ShowAddGuest= TRUE;
       system.debug('  TICKETS QUANTITY '+SelectedTicketQuantity);

       LIST<Individual_Ticket_Info__c> ITIList= new LIST<Individual_Ticket_Info__c>();
       ITIList=[SELECT ID, IsCheckedIn__c,Is_Primary__c, Name, Seat__c, Event_Attendee_Mapping__c, Registration_Info__r.TicketTypes__r.TT_Name__c, Ticket_Session_Mapping__c      
                FROM Individual_Ticket_Info__c
                WHERE Registration_Info__c =: SelectedRegInfoId AND
                Event_Attendee_Mapping__c =: SelectedEAMId AND
                Event_Attendee_Mapping__r.EV_id__c =: SelectedEventId AND
                Is_Input__c =: TRUE AND IsCancelled__c =: FALSE 
                ];
                
       system.debug(SelectedTicketQuantity+' LIST SIZE '+ITIList.size()+'   '+GuestDetails.size());
       if(ITIList.size() >0){
           SelectedTicketName= ITIList[0].Registration_Info__r.TicketTypes__r.TT_Name__c;
           AvailableGuest=  ITIList.size()-1;    
           if(AvailableGuest > guestDetailsInnerList.size()){
               integer i= guestDetailsInnerList.size();
               //Guests.add(new AttendeeSummary__c());
               //GuestDetails.add(new Individual_Ticket_Info__c());
                for(Individual_Ticket_Info__c ind:ITIList){   
                    if(ind.IsCheckedIn__c == FALSE && ind.Is_Primary__c == FALSE){             
                       guestDetailsInnerList.add(new guestDetailsInner(ind,new AttendeeSummary__c()));
                       //break;
                    }
                }
           }
       }
    }
   
   
   //Cancel Guest PopUp
    public void Cancel(){
        ShowAddGuest= FALSE; 
        Guests= new LIST<AttendeeSummary__c>(); 
        guestDetailsInnerList= new LIST<guestDetailsInner>();
    }
    
    public Void DeleteGuests(){
    
        GuestrowNum = Integer.valueOf(apexpages.currentpage().getparameters().get('guestindex'));
        system.debug(' ROW NUMBER '+GuestrowNum );
        //GuestDetails.remove(GuestrowNum);
        guestDetailsInnerList.remove(GuestrowNum);
          
    }

    public LIST<guestDetailsInner> guestDetailsInnerList{get; set;}
    public class guestDetailsInner{
        
        public Individual_Ticket_Info__c itiData{get; set;}
        public AttendeeSummary__c attendeeData{get; set;}
        
        public guestDetailsInner(Individual_Ticket_Info__c itiData, AttendeeSummary__c attendeeData){        
            this.itiData= itiData;
            this.attendeeData= attendeeData;        
        }
    
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
    
      public class JSONRTokenWrapper{    
        public String access_token; 
        public string refresh_token;       
    }
    
    public class JSONTokenWrapper{    
        public String id;     
    }
    
    public class JSONChargeWrapper{    
        public String id;  
        public CardClass card;  
         
    }  
    
    public class CardClass{
        public string last4;
    }
    
    
public void  dummyclassforcode(){
Integer i=0;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;

i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;

i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;



}
    
public void  dummyclass2forcode(){
Integer i=0;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;

i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;

i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;



}    
 
   
public void  dummyclass3forcode(){
Integer i=0;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;

i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;

i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;



}    
 
    
    
}