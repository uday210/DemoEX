public with sharing class SA_manageeventsController {
        
    public List<User_Profile_Event__c> listOfEvents{get;set;}
    public Event__c CreateEvent{get;set;}
    public String SelectedEvent {get;set;}
    public Event__c ShowEvent{get;set;}
    public Event__c DeleteEvent{get;set;}
    public String EventId{get;set;}
    public List<Event__c> EventDetails{get;set;}
    public Integer NoofAttendees{get;set;}
    public Integer NoOfTicketsSold{get;set;}
    public Integer NoOfItemsSold{get;set;}
    public Integer Revenue{get;set;}
    public Integer NoOfcheckins{get;set;}
    public Boolean EventPopUp{get;set;}
    public String LogoName{get; set;}
    Public transient Blob Logo{get; set;}
    public String EventLogoError {get;set;}
    public document EventDocument {get;set;}
    public String selectedTab;
    public boolean istab1disabled;
    public boolean istab2disabled;
    public boolean istab3disabled;
    public LIST<SelectOption> EventDate{get;set;}
    public String SelectedDate{get; set;}
    public LIST<String> SelectedDates{get; set;}
    public MatchLeads_Days__c MDays{get;set;}
    public LIST<AddMultipleSessions> AddMSessions{get;set;}
    public Integer rowNum{get;set;}
    public Decimal FormattedString{get;set;}
    public LIST<SelectOption> FeeTypes{get; set;}
    
    public SA_manageeventsController(ApexPages.StandardController controller) {
        SelectedEvent = '';
        EventId  = '';
        EventPopUp = False;    
        EventDetails = new List<Event__c>();
        AddMSessions = new List<AddMultipleSessions>();
        ListOfEvents();
        selectedtab = 'Event Details';
        FeeTypes= new LIST<SelectOption> ();
        LIST<String> FeeTypeList= new LIST<String>();
        Schema.DescribeFieldResult FeeField= Event__c.Fee_Type__c.getDescribe();
        List<Schema.PicklistEntry> FeeTypeValues= FeeField.getPicklistValues();
        for(Schema.PicklistEntry type: FeeTypeValues){ 
            FeeTypeList.add(type.getValue()); 
        } 
        for(String str: FeeTypeList){
            FeeTypes.add(new SelectOption(str, str));
        }
        List<User> loginUserProfile= new LIST<User>();
            loginUserProfile= [SELECT ID, is_Event_Admin_Staff_User__c 
                               FROM User 
                               WHERE is_Event_Admin_Staff_User__c =: TRUE AND
                               Id =: UserInfo.getUserId() AND 
                               ScanAttendee_User__c =: TRUE];            
            isEventAdminStaffUser= FALSE;                               
            system.debug(loginUserProfile.size()+'  LOGIN USER ID '+loginUserProfile);                               
            if(loginUserProfile.size() >0){
                isEventAdminStaffUser= TRUE;

                }             
            system.debug(' STAFF USER  '+isEventAdminStaffUser);

    }
    
    
    
    public Boolean isEventAdminStaffUser{get;set;}
    public SET<Id> EventIds{get; set;}
    
    public Void ListOfEvents(){
    
        EventPopUp = False;
        listOfEvents = new List<User_Profile_Event__c>();
        EventDetailsInnerList= new List<EventDetailsInner>();
        EventIds= new SET<Id>();
         system.debug(' UserInfo.getUserName() ::::11111 UserInfo.getUserName()   ' +UserInfo.getUserName() );
        listOfEvents =[SELECT EV_id__r.Status__c, EV_id__r.StartTime__c, EV_id__r.SecondaryCategory__c, 
                       EV_id__r.Primary__c, EV_id__r.Name, EV_id__r.Id, EV_id__r.EV_Title__c, EV_id__r.EV_StartDate__c,
                       EV_id__r.EV_HostingZipcode__c, EV_id__r.EV_HostingTimeZone__c, EV_id__r.EV_HostingState__c,
                       EV_id__r.EV_HostingPostalCode__c,EV_id__r.Need_FloorMap__c, EV_id__r.EV_HostingPhone__c, 
                       EV_id__r.EV_HostingLocation__c, EV_id__r.EV_HostingCountry__c,EV_id__r.TwitterId__c,
                       EV_id__r.FacebookId__c,EV_id__r.OrganizerId__c, EV_id__r.EV_HostedByEventBrite__c, 
                       EV_id__r.EV_HistingAddr1__c, EV_id__r.EV_EventLogo__c,EV_id__r.CCRDetails_Required__c, 
                       EV_id__r.EV_EndTime__c,EV_id__r.EV_EndDate__c, EV_id__r.EV_Description__c, 
                       Profile_id__r.PR_Name__c,EV_id__r.isActive__c, EV_id__r.CreatedDate, EV_id__r.Attendee_Tags__c,
                       EV_id__r.EV_HostingOrgName__c, EV_id__r.AS_HostingCity__c,EV_id__r.AS_HostingAddr2__c,
                       EV_id__r.Is_MatchMaking_Event__c , EV_id__r.EV_WebsiteURL__c, EV_id__r.EV_HostingCountryNew__c,
                       EV_id__r.EV_HostingStateNew__c, EV_id__r.Sales_Tax__c, EV_id__r.Fee_Type__c
                        FROM User_Profile_Event__c 
                        WHERE EV_id__r.isActive__c =: true
                        AND User_id__r.UserName =: UserInfo.getUserName() 
                        AND EV_id__r.Id != NULL
                        AND UEP_isActive__c =: TRUE
                        AND (Profile_id__r.PR_Name__c =: 'EventAdmin' OR Profile_id__r.PR_Name__c =: 'EventAdmin Staff')
                        ORDER BY EV_id__r.EV_EndDate__c DESC];
        system.debug('   '+listOfEvents.size()+'  LIST OF EVENTS '+listOfEvents );
        if(listOfEvents.size()>0){
            for(User_Profile_Event__c UPE: listOfEvents){
                EventIds.add(UPE.EV_id__c);
            }
         //SelectedEvent =  listOfEvents[0].EV_id__r.id; 
       } 
       EventStatics();
    }
    
     public void EventStatics(){

        EventPopUp = False;
        NoofAttendees = 0;    
        NoOfTicketsSold  = 0;   
        Revenue = 0;  
        NoOfItemsSold  = 0; 
        NoOfcheckins = 0;
        
        MAP<Id, Integer> AttendeesMAP= new MAP<Id, Integer>();
        MAP<Id, Integer> CheckinsMAP= new MAP<Id, Integer>();        
        MAP<Id, Integer> TicketsSoldMAP= new MAP<Id, Integer>();        
        MAP<Id, Integer> ItemsSoldMAP= new MAP<Id, Integer>();        
        MAP<Id, String> RevenueMAP= new MAP<Id, String>(); 
        system.debug('EventIds::::EventIds' + EventIds);
        AggregateResult [] Attendees= [SELECT COUNT(AS_id__c) total, EV_id__c event   
                                       FROM Event_Attendee_Mapping__c 
                                       WHERE IsCancelled__c =: FALSE
                                       AND EV_id__c IN: EventIds
                                       GROUP BY EV_id__c];
         system.debug('Attendees::::Attendees' + Attendees);
        for(AggregateResult ar : Attendees){
            AttendeesMAP.put(String.valueOf(ar.get('event')), Integer.valueOf(ar.get('total')));
        }
        
      /*  AggregateResult [] TicketsSold= [SELECT SUM(Available_Quantity__c) total, Event__c event 
                                         FROM Dummay__c
                                         WHERE TicketTypes__c != NULL
                                         AND Event__c IN: EventIds
                                         AND TicketTypes__r.TT_Name__c != 'Guest' 
                                         AND TicketTypes__r.TT_Name__c != 'Attendee Staff'
                                         GROUP BY Event__c];
        // AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE
        */
        AggregateResult [] TicketsSold= [SELECT SUM(TT_Sold__c) total, EV_id__c event 
                                         FROM TicketTypes__c
                                         WHERE EV_id__c IN: EventIds
                                         AND TT_Name__c != 'Guest' 
                                         AND TT_Name__c != 'Attendee Staff'
                                         GROUP BY EV_id__c];
        
     /*   for (AggregateResult ar : TicketsSold){                
            TicketsSoldMAP.put(String.valueOf(ar.get('event')), Integer.valueOf(ar.get('total')));            
        }  
       */
        for(Event__c eves : [Select id,(select id,name,Amount__c,customer_key__r.isInserted__c,Tickets_Quantty__c,For_Refund__c from Dummays__r where customer_key__r.isInserted__c=true and TicketTypes__r.TT_Name__c!='Guest' and TicketTypes__r.TT_Name__c!='Attendee Staff') from Event__c  where id In :EventIds]){
              integer soldTicks =0;
                 for(Dummay__c d: eves.Dummays__r){
                    if(null != d.Tickets_Quantty__c){
                     soldTicks += integer.ValueOf(d.Tickets_Quantty__c);
                    }
               } 
             TicketsSoldMAP.put(String.valueOf(eves.id), Integer.valueOf(soldTicks));       
           }
        
        
        AggregateResult [] ItemsSold= [SELECT SUM(Available_Quantity__c) total, Event__c event
                                       FROM Dummay__c
                                       WHERE Item__c != NULL
                                       AND Event__c IN: EventIds
                                       GROUP BY Event__c];
                                       //AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE];
        
        for(AggregateResult ar : ItemsSold){
            ItemsSoldMAP.put(String.valueOf(ar.get('event')), Integer.valueOf(ar.get('total')));
        }
        
                       
        AggregateResult [] RevenueEarned=[SELECT SUM(Amount__c) total, Event__c event 
                                          FROM Dummay__c
                                          WHERE (TicketTypes__c != NULL OR Item__c != NULL)
                                          AND Event__c IN: EventIds
                                          GROUP BY Event__c];
                                          //AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE];
        
        for (AggregateResult ar : RevenueEarned){    
            RevenueMAP.put(String.valueOf(ar.get('event')), String.valueOf(ar.get('total')));
        } 
        
        AggregateResult [] CheckedInAgg= [SELECT COUNT(ID) checkin, Registration_Info__r.Event__c event 
                                          FROM Individual_Ticket_Info__c
                                          WHERE Registration_Info__r.Event__c IN: EventIds AND 
                                          Scanned_by__c != NULL AND IsCheckedIn__c =: TRUE AND
                                          Event_Attendee_Mapping__c != NULL
                                          AND IsCancelled__c =: FALSE
                                          AND Is_Input__c =: TRUE
                                          AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE
                                          GROUP BY Registration_Info__r.Event__c];            
         
        for (AggregateResult ar : CheckedInAgg){    
            CheckinsMAP.put(String.valueOf(ar.get('event')), Integer.valueOf(ar.get('checkin')));
        } 
                                    
        for(User_Profile_Event__c UPE: listOfEvents){
            
            system.debug('  USER PROFILE EVENT  '+UPE);
            String RevenueString= '0';

            NoOfTicketsSold= 0;
            NoOfItemsSold= 0;
            NoOfcheckins= 0;  
            FormattedString= 0;
            
            if(AttendeesMAP.get(UPE.EV_id__c) != NULL){
                NoofAttendees=  AttendeesMAP.get(UPE.EV_id__c);
            }else{
                NoofAttendees= 0;            
            }
            
            if(TicketsSoldMAP.get(UPE.EV_id__c) != NULL){
                NoOfTicketsSold= TicketsSoldMAP.get(UPE.EV_id__c);
            }else{
                NoOfTicketsSold= 0;            
            }
            
            if(ItemsSoldMAP.get(UPE.EV_id__c) != NULL){
                NoOfItemsSold= ItemsSoldMAP.get(UPE.EV_id__c);
            }else{
                NoOfItemsSold= 0;            
            }
            
            if(CheckinsMAP.get(UPE.EV_id__c) != NULL){
                NoOfcheckins= CheckinsMAP.get(UPE.EV_id__c);
            }else{
                NoOfcheckins= 0;            
            }
           
            RevenueString = RevenueMAP.get(UPE.EV_id__c);
            if(RevenueString != NULL){    
                FormattedString= Decimal.valueof(RevenueString); 
            }
           
         system.debug(NoofAttendees+'  INNER LIST SIZE000000000 '+NoOfTicketsSold+'   '+NoOfItemsSold+'   '+NoOfcheckins+'   '+FormattedString );       
         Boolean haveDeleteOption= FALSE;
        if(UPE.EV_id__r.EV_EndDate__c < System.Today() && UPE.Profile_id__r.PR_Name__c != 'EventAdmin Staff'){
            haveDeleteOption= TRUE;
        } 
        Boolean isOneDayEvent= FALSE;   
        if(UPE.EV_id__r.EV_StartDate__c == UPE.EV_id__r.EV_EndDate__c){
            isOneDayEvent= TRUE;
        }
        EventDetailsInnerList.add(new EventDetailsInner(UPE, NoofAttendees, NoOfTicketsSold, NoOfItemsSold, NoOfcheckins,FormattedString, haveDeleteOption, isOneDayEvent));
            
        }
        
        system.debug(EventDetailsInnerList.size()+'  INNER LIST SIZE1111111111 '+EventDetailsInnerList);
        
    }

    public LIST<EventDetailsInner> EventDetailsInnerList{get; set;}
    public class EventDetailsInner{
        
        public User_Profile_Event__c UPEData{get; set;}
        public Integer AttendeeCount{get; set;}
        public Integer TicketSold{get; set;}
        public Integer ItemsSold{get; set;}
        public Integer CheckinsCount{get; set;}   
        public Decimal RevenueGenerated{get; set;}     
        public Boolean isDeleteAvailable{get; set;}
        public Boolean isOneDayEvent{get; set;}
                
        public EventDetailsInner(User_Profile_Event__c UPEData, Integer AttendeeCount, Integer TicketSold, Integer ItemsSold, Integer CheckinsCount, Decimal RevenueGenerated, Boolean isDeleteAvailable, Boolean isOneDayEvent){
        
            this.UPEData= UPEData;
            this.AttendeeCount= AttendeeCount;
            this.TicketSold= TicketSold;
            this.ItemsSold= ItemsSold;
            this.CheckinsCount= CheckinsCount;
            this.RevenueGenerated= RevenueGenerated;
            this.isDeleteAvailable= isDeleteAvailable;  
            this.isOneDayEvent= isOneDayEvent;
        }
    }
    
    
    public void ShowEventDetails(){   
        EventPopUp = True;  
        system.debug(SelectedEvent +'  GET EVENT ID  '+ApexPages.CurrentPage().getParameters().get('EventName'));
        SelectedEvent = ApexPages.CurrentPage().getParameters().get('EventName');
         system.debug(SelectedEvent +'  SET EVENT ID  '+ApexPages.CurrentPage().getParameters().get('EventName'));       
        // SelectedEvent =  listOfEvents[0].EV_id__r.id; 
                    selectedTab ='Event Details';
        if(SelectedEvent != null){
            EventDetails = new List<Event__c>();
            
            EventDetails = [SELECT e.Status__c, e.StartTime__c, e.SecondaryCategory__c, e.Primary__c,e.Need_FloorMap__c, 
                                    e.Name,e.Id, e.Event_ZipCode__c, e.Event_PostalCode__c, e.EventDiversityValues__c,Attendee_Types__c, 
                                    e.Ev_RequiredFields__c, e.EV_WebsiteURL__c, e.EV_Title__c, e.EV_StartDate__c, e.EV_SiteLocation__c, 
                                    e.EV_RedirectURI__c, e.EV_Publish__c, e.EV_IncludedFields__c, e.EV_HostingZipcode__c, e.EV_HostingTimeZone__c, 
                                    e.EV_HostingState__c, e.EV_HostingStateNew__c, e.EV_HostingPostalCode__c, e.EV_HostingPhone__c,
                                    e.EV_HostingOrgName__c, e.EV_HostingLocation__c, e.EV_HostingFax__c, e.EV_HostingCountry__c, e.EV_HostingCountryNew__c, 
                                    e.EV_HostedByEventBrite__c, e.EV_HistingAddr1__c, e.EV_EventLogo__c, e.EV_EndTime__c, e.EV_EndDate__c,
                                    e.Owner.ID,e.EV_Description__c, e.EV_CustomReg__c, e.EV_ContactURL__c, e.AS_HostingCity__c, e.AS_HostingAddr2__c,
                                    e.TwitterHashTag__c,e.isActive__c,TwitterId__c,FacebookId__c,OrganizerId__c,Event_Type__c,Is_MatchMaking_Event__c, 
                                    Sales_tax__c, Fee_Type__c
                            FROM Event__c e 
                            WHERE ID =: SelectedEvent 
                            AND isActive__c=:TRUE]; 
            
            if(EventDetails.size() > 0){  
                CreateEvent= new Event__c();
                ShowEvent= new Event__c();                
                ShowEvent = EventDetails[0]; 
                CreateEvent = EventDetails[0];
                if(CreateEvent.Fee_Type__c == NULL){
                    CreateEvent.Fee_Type__c= 'Include the fee in the ticket price';
                }
            }                                         
        }
    }
    
    public void EventId(){
        ShowEventDetails();
        EventStatics();   
    }
    
    public void DeleteEvent(){
        SelectedEvent = ApexPages.CurrentPage().getParameters().get('EventName');
        DeleteEvent = new Event__c();
        if(SelectedEvent != null){
            DeleteEvent = [SELECT ID,isActive__c FROM Event__c WHERE ID =: SelectedEvent AND isActive__c=:TRUE]; 
            DeleteEvent.isActive__c = FALSE;
            Database.Update(DeleteEvent,false); 
            ListOfEvents();                          
        }
    }
    
    
    public void SaveEvent(){ 
        ShowEventDetails();   
        system.debug(EventDetails.size()+'   EVENT DETAILS '+EventDetails);
        if(EventDetails.size() > 0){
            system.debug(EventDetails.size()+'   EVENT DETAILS FOR EDIT '+EventDetails);            
            ShowEvent = CreateEvent;
            
            if(Logo != null && ( LogoName != '' || LogoName != NULL )){
            
                //if(Logo.size()!= null){
                system.debug('  LOGO SIZE '+Logo.size());
                    if(Logo.size() < 1048576 ){
                    
                        EventLogoError = '';
                        
                        EventDocument =new document();
                        EventDocument.body = Logo;
                        EventDocument.folderid = '00lF0000001VI7Y';
                        
                        EventDocument.IsPublic = True;
                        EventDocument.Name = LogoName;
                        DataBase.saveResult docSaveResult = DataBase.insert(EventDocument, false);
                        
                        String eventold;
                        
                        if(ShowEvent.EV_EventLogo__c != null){
                            eventold = ShowEvent.EV_EventLogo__c;
                        }
                        
                        if(docSaveResult.isSuccess()){
                            ShowEvent.EV_EventLogo__c = docSaveResult.getId();
        
                            if(eventold != null){
                                try{
                                    document dd = [SELECT ID, NAME FROM document WHERE id=: eventold];
                                    Database.delete(dd);
                                }catch(Exception e){}  
                            }
                        }
                        else{
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, String.valueOf(docSaveResult.getErrors()))); 
                        }
                    }else{
                        EventLogoError= 'Please make sure the  file is not more than 100 kb';
                    }
               // }
            }else{
                EventLogoError= 'Please Select Valid Image file.';
            }    
            ShowEvent.isActive__c= TRUE;
            ShowEvent.OrganizerId__c= UserInfo.getUserName();
            Database.Update(ShowEvent,false); 
            if(ShowEvent.Sales_Tax__c != NULL || ShowEvent.Sales_Tax__c != 0){
                LIST<Item__c> ItemsList= new LIST<Item__c>();
                LIST<Item__c> updateItemsList= new LIST<Item__c>();                
                ItemsList= [SELECT ID, Sales_Tax__c FROM Item__c WHERE Event__c =: ShowEvent.Id AND isTaxable__c =: TRUE];
                if(ItemsList.size() >0){
                    for(Item__c item: ItemsList){
                        item.Sales_Tax__c= ShowEvent.Sales_Tax__c;
                        updateItemsList.add(item);     
                    }
                    Database.Update(updateItemsList, FALSE);
                }
            }
            //InsertTicketsToEvent();
            SelectedEvent= ShowEvent.Id;
            enableSessionsTab(SelectedEvent);
            ListOfSessions(ShowEvent);
            system.debug(EventDetails.size()+'   EVENT DETAILS FOR EDIT END '+EventDetails);            
        }else{
            system.debug(EventDetails.size()+'   EVENT DETAILS FOR INSERT  '+EventDetails);            
            if(Logo != null && ( LogoName != '' || LogoName != NULL )){
            
                   // if(Logo.size()!= null){
                    
                        if(Logo.size() < 1048576){

                            EventLogoError = '';
                            
                            EventDocument =new document();
                            EventDocument.body = Logo;
                            EventDocument.folderid = '00lF0000001VI7Y';
                            
                            EventDocument.IsPublic = True;
                            EventDocument.Name = LogoName;
                            DataBase.saveResult docSaveResult = DataBase.insert(EventDocument , false);
                            
                            String eventold;
    
                            if(docSaveResult.isSuccess()){
                                if(CreateEvent.EV_EventLogo__c != null){ 
                                    eventold = CreateEvent.EV_EventLogo__c;
                                    
                                    document dd = [SELECT ID, NAME FROM document WHERE id=: eventold];
                                    Database.delete(dd);
                                }
                                CreateEvent.EV_EventLogo__c = docSaveResult.getId();
                            }
                            else{
                                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, String.valueOf(docSaveResult.getErrors()))); 
                            } 
                        }
                    else{
                        EventLogoError = 'Please make sure the  file is not more than 100 kb';
                    }
                //}
            }
            CreateEvent.isActive__c= TRUE;
            CreateEvent.OrganizerId__c= UserInfo.getUserName();
            Database.SaveResult createEventResult= Database.insert(CreateEvent, false);
            //Database.Insert(CreateEvent,false);
            SelectedEvent= CreateEvent.Id;
            system.debug(createEventResult+'   EVENT DETAILS FOR INSERT END '+CreateEvent);                      
            InsertTicketsToEvent();
            enableSessionsTab(SelectedEvent);

            ListOfSessions(CreateEvent);
            selectedTab ='Sessions';
        }
        
    }

    public void CreateEvent(){
        CreateEvent = new Event__c();
        CreateEvent.Fee_Type__c= 'Include the fee in the ticket price';

        MDays = new MatchLeads_Days__c();
        EventPopUp = True;   
        selectedTab ='Event Details';        
    }
    
    public void Cancel(){
        EventPopUp = False;
    }
    
    public Pagereference ManageEvent(){  
        SelectedEvent= ApexPages.CurrentPage().getParameters().get('EventName');
        system.debug('  EVNT NAME  '+SelectedEvent );
        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
        if (counter == null) {
            counter = new Cookie('counter', SelectedEvent ,null,-1,false);
        }
        else{
            counter = new Cookie('counter', SelectedEvent ,null,-1,false);
        }

        ApexPages.currentPage().setCookies(new Cookie[]{counter});
        Pagereference Pg;
        LIST<User_Profile_Event__c> LoginUserProfile= new LIST<User_Profile_Event__c>();
        LoginUserProfile= [SELECT Profile_id__r.PR_Name__c FROM User_Profile_Event__c WHERE User_id__c =: UserInfo.getUserId()];
        String LoginId= UserInfo.getUserId();
        LIST<TicketTypes__c> ExistingTicketsList= new LIST<TicketTypes__c>();
        ExistingTicketsList= [SELECT ID, TT_Name__c FROM TicketTypes__c WHERE (TT_Name__c =: 'Guest' OR TT_Name__c =: 'Attendee Staff') AND EV_id__c =: SelectedEvent];
        includeSADetailsToBLEvent insertTickets= new includeSADetailsToBLEvent();        
        if(ExistingTicketsList.size() == 0){
            insertTickets.insertTicketsForEvent( LoginId, SelectedEvent);
        }
        insertTickets.insertGuestToAttendee(SelectedEvent);
        
        /*
        if(LoginUserProfile.size() >0){    
            if(LoginUserProfile[0].Profile_id__r.PR_Name__c == 'EventAdmin'){    
                Pg = new Pagereference('/apex/SA_EventDashboard');
            }else if(LoginUserProfile[0].Profile_id__r.PR_Name__c == 'EventAdmin Staff'){
                Pg = new Pagereference('/apex/SA_StaffReports');                
            }
        }
        */
        Pg = new Pagereference('/apex/SA_EventDashboard');                
        return Pg ;
    }
 // ----------------------------------------------------------- Tabs Code Start -------------------------------------------------   
            
    public string getselectedtab(){
        return selectedtab;
    }  

    public boolean getistab1disabled(){
        return selectedTab <> 'Event Details';     
    }
    

    public boolean getistab2disabled(){
        return selectedTab <> 'Sessions';     
    }
    
     public boolean getistab3disabled(){
        return selectedTab <> 'Sales Tax';     
    }
    
    public void previous(){
        selectedTab ='Event Details';
    }
    
    public void enableSessionsTab(String EventId){
        LIST<MatchLeads_Days__c> DaysList = new LIST<MatchLeads_Days__c>();
        system.debug(DaysList.size()+' SELECTED EVENT111111111 '+EventId);
        DaysList= [SELECT Id,MatchLeads_Date__c,End_Time__c,Start_time__c,Session_Name__c FROM MatchLeads_Days__c WHERE Event__c =: EventId AND Event__c != NULL];
        AddMSessions= new LIST<AddMultipleSessions>();
        system.debug(DaysList.size()+' SELECTED '+AddMSessions.size()+'EVENT2222222222 '+EventId);
        if(DaysList.size() >0){
            system.debug('*********** '+DaysList.size());
            for(MatchLeads_Days__c SessionDate: DaysList){
            
                SelectedDate= String.valueOf(SessionDate.MatchLeads_Date__c);
                AddMSessions.add(new AddMultipleSessions(SelectedDate,SessionDate));
            system.debug(AddMSessions.size()+'   @@@@@@@  '+AddMSessions);                
            }
        
        }else{
            AddMSessions.add(new AddMultipleSessions('Select Date', new MatchLeads_Days__c()));
        }

    }
    
    public void ListOfSessions(Event__c ev){
        system.debug('!!!!!111 '+ ev);
        selectedTab = 'Sessions';                 
        EventDate = new list<SelectOption>();
        if(ev.EV_StartDate__c.daysBetween(ev.EV_EndDate__c) != NULL){
            Integer EventDays = ev.EV_StartDate__c.daysBetween(ev.EV_EndDate__c);
     
            EventDate.add(new selectOption('Select Date','Select Date'));
            if(EventDays >= 0){
                Date d = ev.EV_StartDate__c;
                for(Integer i=0; i<= EventDays; i++ ){
                    EventDate.add(new SelectOption(String.valueOf(d),String.valueOf(d.format())));
                    d+=1;
                }
            }
        
        }
        system.debug('!!!!!222 '+ EventDate);
    }
    /** Saving Multiple Sessions Start
    public void SaveSessions(){
        LIST<MatchLeads_Days__c> upsertDatesList= new LIST<MatchLeads_Days__c>();
        
        if(SelectedDates.size() >0){
            for(String s: SelectedDates){
                MDays.MatchLeads_Date__c = Date.Valueof(s);
                upsertDatesList.add(MDays);
            }
        }
        LIST<Database.UpsertResult> DaysUpsert= DataBase.Upsert(upsertDatesList, false);    
        
        ListOfEvents();
        EventPopUp = False;
        CreateEvent = new Event__c();
    }
    
    **/

    
    public void DeleteSessions(){
        rowNum = Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
        AddMSessions.remove(rowNum);   
    }
    
    public void addingMultipleSessions(){ 
        system.debug('*****111 '+ AddMSessions);  
        system.debug('*****222 '+ CreateEvent.Id); 
        AddMSessions.add(new AddMultipleSessions('', new MatchLeads_Days__c()));
        system.debug('*****333 '+ AddMSessions);
    }
    
    public class AddMultipleSessions{
        public MatchLeads_Days__c MDaysObj{get;set;}
        public String SelectedDate{get; set;}

        public AddMultipleSessions(String Sdate, MatchLeads_Days__c md){
            MDaysObj = md;    
            SelectedDate = Sdate;  
        }  
   } 
   
   //----------------- Adding Tickets while adding Event START -------------------------------------
   
   public void InsertTicketsToEvent(){
       
       system.debug('  EVENT CREATED  '+Createevent.id);
       LIST<TicketTypes__c> ExistingTicketsList= new LIST<TicketTypes__c>();
       ExistingTicketsList= [SELECT ID, TT_Name__c FROM TicketTypes__c WHERE (TT_Name__c =: 'Guest' OR TT_Name__c =: 'Attendee Staff') AND EV_id__c =: CreateEvent.Id];
       LIST<TicketTypes__c> InsertTicketsList= new LIST<TicketTypes__c>();
       MAP<String, TicketTypes__c> ticketsMAP=new MAP<String, TicketTypes__c>();
       
       if(ExistingTicketsList.size() >0){
           for(TicketTypes__c ticket: ExistingTicketsList){
               ticketsMAP.put(ticket.TT_Name__c, ticket);
           }
           if(! ticketsMAP.containsKey('Guest')){
               TicketTypes__c guestTicket= new TicketTypes__c(TT_Name__c ='Guest',TT_Amount__c=0,TT_TicketType__c='Free',EV_id__c=CreateEvent.id,TT_Available__c=1,TT_Sold__c=0,OwnerId=UserInfo.getUserId(),Avilable_for_Portal__c=false);
               InsertTicketsList.add(guestTicket);           
           }
           if(! ticketsMAP.containsKey('Attendee Staff')){
               TicketTypes__c attendeeStaffTicket= new TicketTypes__c(TT_Name__c ='Attendee Staff',TT_Amount__c=0,TT_TicketType__c='Free',EV_id__c=CreateEvent.id,TT_Available__c=1,TT_Sold__c=0,OwnerId=UserInfo.getUserId(),Avilable_for_Portal__c=false);
               InsertTicketsList.add(attendeeStaffTicket);
           }
       }else{
           
           TicketTypes__c guestTicket= new TicketTypes__c(TT_Name__c ='Guest',TT_Amount__c=0,TT_TicketType__c='Free',EV_id__c=CreateEvent.id,TT_Available__c=1,TT_Sold__c=0,OwnerId=UserInfo.getUserId(),Avilable_for_Portal__c=false);
           TicketTypes__c attendeeStaffTicket= new TicketTypes__c(TT_Name__c ='Attendee Staff',TT_Amount__c=0,TT_TicketType__c='Free',EV_id__c=CreateEvent.id,TT_Available__c=1,TT_Sold__c=0,OwnerId=UserInfo.getUserId(),Avilable_for_Portal__c=false);
           InsertTicketsList.add(guestTicket);
           InsertTicketsList.add(attendeeStaffTicket);

       }
       if(InsertTicketsList.size()>0){

           Database.SaveResult[] insertTicketsResult= Database.insert(InsertTicketsList, false);
           system.debug('  TICKETS INSERTED '+insertTicketsResult);
           //Database.Insert(InsertTicketsList, FALSE);
       }
       
       

            List<User_Profile_Event__c> insertingNewrecord = new  List<User_Profile_Event__c> ();
            system.debug('UserInfo.getUserName():' + UserInfo.getUserName());
            LIST<AttendeeSummary__c> AttendeesList= new LIST<AttendeeSummary__c>();
            AttendeesList=[SELECT ID, AS_Company__c, AS_Email__c, AS_LastName__c, AS_FirstName__c FROM AttendeeSummary__c WHERE AS_Email__c =: UserInfo.getUserName()]; 
            system.debug('AttendeesList::::' + AttendeesList);
           
            if(AttendeesList.size() >0){
                LIST<Event_Attendee_Mapping__c> EAMList= new LIST<Event_Attendee_Mapping__c>();
                EAMList= [SELECT ID FROM Event_Attendee_Mapping__c WHERE AS_Id__c =: AttendeesList[0].Id AND EV_Id__c =: CreateEvent.Id];
                system.debug('EAMList::::' + EAMList);
                if(EAMList.size() >0){
                }else{
                    Event_Attendee_Mapping__c insertEAM= new Event_Attendee_Mapping__c();            
                    insertEAM.Attendee_Event_IDs__c= AttendeesList[0].Id+'-'+CreateEvent.Id;
                    insertEAM.AS_id__c= AttendeesList[0].Id;
                    insertEAM.EV_id__c= CreateEvent.Id; 
                    insertEAM.Boothleads_Profile__c= 'Event Admin';
                    insertEAM.IsCancelled__c = FALSE;
                    insertEAM.GuestType__c= 'Event Admin';
                    
                    Database.SaveResult insertEAMResult= Database.insert(insertEAM, false);
                    system.debug('  INSERT EAM RESULT '+insertEAMResult);
                    //Database.upsert(insertEAM, Event_Attendee_Mapping__c.EA_AttendeeBarcode__c, FALSE);
                    
                    Constomer__c TransactionInfo = new Constomer__c();
                                
                    TransactionInfo.Email__c= AttendeesList[0].AS_Email__c;
                    TransactionInfo.Customer_Name__c= AttendeesList[0].AS_FirstName__c+' '+AttendeesList[0].AS_LastName__c;
                    TransactionInfo.Isinserted__c = TRUE;        
                    Database.Insert(TransactionInfo,False);
                        
                    Dummay__c  RegistrationNewInfoForTicket= new Dummay__c();        
                        
                        LIST<TicketTypes__c> guestTicket= new LIST<TicketTypes__c>([SELECT ID, TT_Available__c, Available__c, TT_Sold__c FROM TicketTypes__c WHERE TT_Name__c =: 'Guest' AND EV_id__c =: CreateEvent.Id]);
                        RegistrationNewInfoForTicket.AttendeeSummary__c = AttendeesList[0].Id;
                        RegistrationNewInfoForTicket.Company__c = AttendeesList[0].AS_Company__c;
                        RegistrationNewInfoForTicket.Email__c = AttendeesList[0].AS_Email__c;
                        RegistrationNewInfoForTicket.Last_Name__c = AttendeesList[0].AS_LastName__c;
                        RegistrationNewInfoForTicket.First_Name__c = AttendeesList[0].AS_FirstName__c;
                        RegistrationNewInfoForTicket.Event__c = createEvent.Id;
                        RegistrationNewInfoForTicket.TicketTypes__c = guestTicket[0].Id;
                        RegistrationNewInfoForTicket.customer_key__c = TransactionInfo.Id;
                        RegistrationNewInfoForTicket.Update_with_created_date__c = Date.Today();
                        RegistrationNewInfoForTicket.Payment_Status__c =  'Paid';
                        RegistrationNewInfoForTicket.Payment_Type__c = 'Guest';
                        RegistrationNewInfoForTicket.Event_Attendee_Mapping__c =  insertEAM.id;
                        RegistrationNewInfoForTicket.Tickets_Quantty__c = 1;
                        //RegistrationNewInfoForTicket.Event_Attendee_Mapping__c = Event_Attendee.Id;
                        RegistrationNewInfoForTicket.TicketAmount__c= 0;
                        
                        Database.SaveResult insertRegInfoResult= Database.insert(RegistrationNewInfoForTicket, false);
                        if(guestTicket[0].Available__c <= 0){
                            guestTicket[0].TT_Available__c += 1; 
                        }
                        guestTicket[0].TT_Sold__c += 1;
                        Database.Update(guestTicket, FALSE);
                        
                        system.debug(insertRegInfoResult+'  REG INFO LIST RESULT ');
                        system.debug(guestTicket.size()+'  GUEST LIST '+guestTicket);
                }
                
                
                insertingNewrecord= [SELECT id,BLP_id__c,Ev_Id__c,Ev_Id__r.Is_MatchMaking_Event__c 
                                     FROM User_Profile_Event__c 
                                     WHERE EventAdmin_Id__c =:UserInfo.getUserId()
                                     AND (Ev_Id__c = Null OR EV_id__c =: CreateEvent.Id) Limit 1];
                if(insertingNewrecord.size() > 0){   
                    insertingNewrecord[0].EV_id__c = CreateEvent.Id;
                    insertingNewrecord[0].Attendee_Summary__c= AttendeesList[0].Id; 
                    Database.Update(insertingNewrecord[0],False);   
                }else{  
                    Profile__c EventAdminProfile = [select Id from Profile__c where PR_Name__c = 'EventAdmin'];           
                    
                    User_Profile_Event__c EventAdmin_Event = new User_Profile_Event__c();
                    EventAdmin_Event.EV_id__c = CreateEvent.id;
                    EventAdmin_Event.EventAdmin_Id__c = UserInfo.getUserId();
                    EventAdmin_Event.UEP_isActive__c = true;
                    EventAdmin_Event.Profile_id__c = EventAdminProfile.id ;
                    EventAdmin_Event.User_id__c = UserInfo.getUserId();
                    EventAdmin_Event.Attendee_Summary__c= AttendeesList[0].Id; 
                
                    Database.SaveResult res= database.insert(EventAdmin_Event,false);  
                }
            
            }  
   }
   
   
   //----------------- Adding Tickets while adding Event END
       
    // Saving Multiple Sessions Start
    public void SaveSessions(){
 system.debug('$$$$$$111 '+AddMSessions);
        if(AddMSessions.size() >= 1){
            LIST<MatchLeads_Days__c> upsertDatesList= new LIST<MatchLeads_Days__c>();
            system.debug('$$$$$$111 '+AddMSessions);
            for(AddMultipleSessions ses: AddMSessions){

                MatchLeads_Days__c MatchDays = new MatchLeads_Days__c();
                system.debug('$$$$$$222 '+ses);
              
                if(ses.selectedDate != 'Select Date'){
                    MatchDays.MatchLeads_Date__c = Date.Valueof(ses.selectedDate);
                    MatchDays.Session_Name__c = ses.MDaysObj.Session_Name__c;
                    MatchDays.Start_time__c = ses.MDaysObj.Start_time__c;
                    MatchDays.End_Time__c = ses.MDaysObj.End_Time__c;
                    MatchDays.Event__c = SelectedEvent;  
                    MatchDays.UniqueName__c = ses.MDaysObj.Session_Name__c+ '-' +Date.Valueof(ses.selectedDate);           
                    upsertDatesList.add(MatchDays);
                }
               
            }
            system.debug('$$$$$$333 '+upsertDatesList);
            try{
            LIST<Database.UpsertResult> DaysUpsert= DataBase.Upsert(upsertDatesList,MatchLeads_Days__c.UniqueName__c, false);   
           
            system.debug('$$$$$$444 '+DaysUpsert);
             }catch(Exception e){}
        }
        /*SelectedTab= 'Sales Tax';
        updateEvent= new Event__c();
        updateEvent=[SELECT ID, Sales_Tax__c FROM Event__c WHERE ID =: SelectedEvent];
        */
                ListOfEvents();
    } 
    public Event__c updateEvent{get; set;}
    public void previousSessions(){
        
        //SelectedEvent= CreateEvent.Id;
        //enableSessionsTab();
        //ListOfSessions(CreateEvent);
        selectedTab ='Sessions';
    }
    
    public Pagereference saveSalesTax(){
        system.debug('  UPDATE SALES TAX '+updateEvent);
       try{
        updateEvent.isActive__c= TRUE;
        Database.Update(updateEvent);

        EventPopUp= False;
        CreateEvent = new Event__c();
       
        AddMSessions= new LIST<AddMultipleSessions>();
       
        ListOfEvents();
        Cancel();
        }catch(Exception e){}
        system.debug('  EVENTS POPUP  '+EventPopUp);
        Pagereference pg= new Pagereference('/SA_ManageEvents');
        return pg;
    }
       
 // ----------------------------------------------------------- Tabs Code End -------------------------------------------------    

 public PageReference checkUserId() {
     if (userInfo.getUserType() == 'guest') {
         Pagereference pg = new pagereference('/SA_Signup');
         pg.setredirect(true);
         return pg;
     } else {
         return null;
     }
 }

}