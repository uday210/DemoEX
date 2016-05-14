public without sharing class SA_ReportsController {
   
    public SA_ReportsController(){
        
        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
        if(counter !=null){
            selectedEventId= counter.getValue();
            SelectedEvent= new Event__c();
            SelectedEvent= [SELECT  ID, EV_Title__c, EV_HostingLocation__c, EV_HistingAddr1__c, AS_HostingCity__c, 
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
            SessionsList= new LIST<MatchLeads_Days__c>();
            SessionsList= SelectedEvent.MatchLeads_Days__r;                                             
             if(SessionsList.size() >0){
                   WithSessions= TRUE;
                   WithoutSessions= FALSE;
               }else{
                   WithSessions= FALSE;
                   WithoutSessions= TRUE;
               }
            ticketSales();
            //ordersales();
            //checkinStatus();
        }
        system.debug('EVENT ID '+selectedEventId);
        
    }
    
    public Boolean isPastEvent{get; set;}     
    public Boolean isEventAdminStaffUser{get; set;}  

    public String selectedEventId{get; set;}     
    public LIST<MatchLeads_Days__c> SessionsList{get; set;}   
    public Event__c SelectedEvent{get; set;}
    public String ReportName{get; set;}     
    public LIST<Dummay__c> ticketSales{get; set;}
    public LIST<TicketTypes__c> TicketTypesForEvent{get; set;}
    public MAP<String, LIST<Dummay__c>> ticketSalesMAP{get; set;}
    public MAP<String, String> ticketNameMAP{get; set;}   
    public LIST<SelectOption> filterTypes{get; set;}
    public String selectedFilterType{get; set;}

    
    public Boolean ShowTicketSales{get; set;}
    public Boolean ShowItemSales{get; set;}
    

    public Decimal TotalRevenue{get; set;}
    public Integer TotalCheckins{get; set;} 
    
    public void ticketRevenueStatistics(){
    
        AggregateResult [] totalRevenueAgg= [SELECT SUM(Amount__c) 
                                             FROM Dummay__c 
                                             WHERE Event__c =: SelectedEventId AND TicketTypes__c != NULL];
                                            // AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE];
        
        for (AggregateResult agg : totalRevenueAgg){
            String TotalRevenueString; 

            if(agg.get('expr0') != NULL){
                TotalRevenueString= String.valueOf(agg.get('expr0'));
                TotalRevenue=  Decimal.valueOf(TotalRevenueString);
            }else{
                TotalRevenue=0;
            }
        }
        
        AggregateResult [] paymentAgg= [SELECT COUNT(ID) c, SUM(Amount__c) s, Payment_Type__c type
                                        FROM Dummay__c
                                        WHERE Event__c=: selectedEventId AND Payment_Type__c != NULL AND Payment_Type__c != 'Guest' AND TicketTypes__c != NULL
                                        GROUP BY Payment_Type__c];
        //AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE     
        paymentTypeInnerList= new LIST<paymentTypeInner>();
        
        for(AggregateResult agg: paymentAgg){
            if((Decimal)agg.get('s') != 0){
                paymentTypeInnerList.add(new paymentTypeInner((String)agg.get('type'), (Decimal)agg.get('s')));
            }
        }
        
    }
    
    public void itemRevenueStatistics(){
    
        AggregateResult [] totalRevenueAgg= [SELECT SUM(Amount__c) 
                                             FROM Dummay__c 
                                             WHERE Event__c =: SelectedEventId AND Item__c != NULL];

        // AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE];
        for (AggregateResult agg : totalRevenueAgg){
            String TotalRevenueString;
            if(agg.get('expr0') != NULL){
                TotalRevenueString= String.valueOf(agg.get('expr0'));
                TotalRevenue=  Decimal.valueOf(TotalRevenueString);
            }else{
                TotalRevenue=0.0;
            }
        }
        
        AggregateResult [] paymentAgg= [SELECT COUNT(ID) c, SUM(Amount__c) s, Payment_Type__c type
                                        FROM Dummay__c
                                        WHERE Event__c=: selectedEventId AND Payment_Type__c != NULL AND Payment_Type__c != 'Guest' AND Item__c != NULL
                                        GROUP BY Payment_Type__c];
         //AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE                               
        paymentTypeInnerList= new LIST<paymentTypeInner>();
        
        for(AggregateResult agg: paymentAgg){
            if((Decimal)agg.get('s') != 0){
                paymentTypeInnerList.add(new paymentTypeInner((String)agg.get('type'), (Decimal)agg.get('s')));
            }
        }
        
        
    }
    
     public void RevenueStatistics(){
    
        AggregateResult [] totalRevenueAgg= [SELECT SUM(Amount__c) 
                                             FROM Dummay__c 
                                             WHERE Event__c =: SelectedEventId AND (TicketTypes__c != NULL OR Item__c != NULL)
                                             ];
         //AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE
        for (AggregateResult agg : totalRevenueAgg){
            if(agg.get('expr0') != NULL){
                TotalRevenue=  Integer.valueOf(agg.get('expr0'));
            }else{
                TotalRevenue=0;
            }
        }
        
        AggregateResult [] paymentAgg= [SELECT COUNT(ID) c, SUM(Amount__c) s, Payment_Type__c type
                                        FROM Dummay__c
                                        WHERE Event__c=: selectedEventId AND Payment_Type__c != NULL AND Payment_Type__c != 'Guest' AND (TicketTypes__c != NULL OR Item__c != NULL)
                                        GROUP BY Payment_Type__c];
               // AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE                         
        paymentTypeInnerList= new LIST<paymentTypeInner>();
        
        for(AggregateResult agg: paymentAgg){
            if((Decimal)agg.get('s') != 0){
                paymentTypeInnerList.add(new paymentTypeInner((String)agg.get('type'), (Decimal)agg.get('s')));
            }
        }
        
    }
    
    public LIST<paymentTypeInner> paymentTypeInnerList{get; set;}
    public class paymentTypeInner{
   
        public String typeData{get; set;}
        public Decimal typeCount{get; set;}
        
        public paymentTypeInner(String typeData, Decimal typeCount){
            
            this.typeData= typeData;
            this.typeCount= typeCount;
            
        }
    
    }
    
    public void ticketSales(){
        ShowTicketSales= TRUE;
        ShowItemSales= FALSE;
        ShowCheckInStatus= FALSE;
        ShowOrderSales= FALSE;
        ShowCHForAttendee= FALSE;
        ShowCHForTicket= FALSE;
        ShowRefundList= FALSE;
        ReportName='Report On Ticket Sales';
        ticketsSalesInnerList= new LIST<ticketsSalesInner>();
        filterTypes= new LIST<SelectOption>();
        filterTypes.add(new SelectOption('Ticket','Ticket'));
        filterTypes.add(new SelectOption('Company','Company'));
        filterTypes.add(new SelectOption('Payment Type','Payment Type'));
                  
        selectedFilterType= 'Company';
        ticketRevenueStatistics();
        ticketSalesReport();
    
    } 
    
    public void itemSales(){
    
        ShowItemSales= TRUE;
        ShowTicketSales= FALSE;
        ShowCheckInStatus= FALSE;
        ShowOrderSales= FALSE;
        ShowCHForAttendee= FALSE;
        ShowCHForTicket= FALSE;
        ShowRefundList= FALSE;
        ReportName='Report On Item Sales';
        ticketsSalesInnerList= new LIST<ticketsSalesInner>();
        CheckInStatusList= new LIST<LIST<Individual_Ticket_Info__c>>();
        
        filterTypes= new LIST<SelectOption>();
        filterTypes.add(new SelectOption('Item','Item'));
        filterTypes.add(new SelectOption('Company','Company'));
        filterTypes.add(new SelectOption('Payment Type','Payment Type'));
                  
        selectedFilterType= 'Company';
        itemRevenueStatistics();
        ticketSalesReport();
    
    }
    public boolean ShowCheckInStatus{get; set;}
    public LIST<SelectOption> CheckInFilterOptions{get; set;} 
    public String SelectedCheckInFilter{get; set;}
    
    public void checkinStatus(){
        

        ShowItemSales= FALSE;
        ShowTicketSales= FALSE;
        ShowCheckInStatus= TRUE;
        ShowOrderSales= FALSE;
        ShowCHForAttendee= FALSE;
        ShowCHForTicket= FALSE;
        ShowRefundList= FALSE;
        ReportName='Report On CheckIn Status';
        ticketsSalesInnerList= new LIST<ticketsSalesInner>();
        CheckInStatusList= new LIST<LIST<Individual_Ticket_Info__c>>();
        
        filterTypes= new LIST<SelectOption>();
        CheckInFilterOptions= new LIST<SelectOption>();
        LIST<User_Profile_Event__c> Users= new LIST<User_Profile_Event__c>();
        CheckInFilterOptions.add(new SelectOption('All','All'));
        system.debug(selectedEventId +'  LOGIN USER ID '+UserInfo.getUserId());
        Users=[SELECT ID, User_id__c, User_id__r.firstname, User_id__r.lastname, User_id__r.Name
               FROM User_Profile_Event__c 
               WHERE EV_id__c =: selectedEventId AND               
               (Profile_id__r.PR_Name__c =: 'EventAdmin Staff' OR Profile_id__r.PR_Name__c =: 'EventAdmin') AND
               UEP_isActive__c =: TRUE AND User_Id__r.ScanAttendee_User__c =: TRUE];
        // EventAdmin_Id__c =: UserInfo.getUserId() AND 
        system.debug(Users.size()+'   USERS SIZE  '+Users);
        if(Users.size()>0){
        
            for(User_Profile_Event__c UPE: Users){
                system.debug(UPE.User_id__r.Name+'  UPE INFO '+UPE.User_id__r.firstname+'  '+UPE.User_id__r.lastname);
                CheckInFilterOptions.add(new SelectOption(UPE.User_id__c, UPE.User_id__r.firstname+' '+UPE.User_id__r.lastname));
            }
            
        }
        SelectedCheckInFilter= 'All';
                system.debug(CheckInFilterOptions.size()+'  FILTER OPTIONS '+CheckInFilterOptions);
        AggregateResult [] CheckedInAgg= [SELECT COUNT(ID)
                                          FROM Individual_Ticket_Info__c
                                          WHERE Registration_Info__r.Event__c =: selectedEventId AND 
                                          Scanned_by__c != NULL AND IsCheckedIn__c =: TRUE AND
                                          Event_Attendee_Mapping__c != NULL
                                          AND IsCancelled__c =: FALSE
                                          AND Is_Input__c =: TRUE
                                          AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE];
                                          
        for(AggregateResult agg: CheckedInAgg){
        
           TotalCheckins=  Integer.valueOf(agg.get('expr0'));
        
        }
        checkInStatusReport();
    
    }
    
    public Boolean ShowOrderSales{get; set;}
    public LIST<Constomer__c> OrdersList{get; set;}
    
    
    public void orderSales(){
    system.debug('111111111111111111111');
        ShowOrderSales= TRUE;
        ShowItemSales= FALSE;
        ShowTicketSales= FALSE;
        ShowCheckInStatus= FALSE;
        ShowCHForAttendee= FALSE;
        ShowCHForTicket= FALSE;
        ShowRefundList= FALSE;
        ReportName='Report On Orders';
        OrdersList= new LIST<Constomer__c>();

        
        ticketsSalesInnerList= new LIST<ticketsSalesInner>();
        orderSalesInnerList= new LIST<LIST<orderSalesInner>>();
        CheckInStatusList= new LIST<LIST<Individual_Ticket_Info__c>>();
        refundsList= new LIST<LIST<Individual_Ticket_Info__c>>();
        CheckinHistoryTicketSessionInnerList= new LIST<CheckinHistoryTicketSessionInner>();
        
         LIST<Dummay__c> RegInfosList= new LIST<Dummay__c>();
         RegInfosList= [SELECT ID, DiscountValue__c, TicketTypes__c, First_Name__c, TicketAmount__c, Last_Name__c, Email__c, Company__c, 
                       Registered_Date__c, Payment_Status__c, Payment_Type__c, Phone__c, Amount__c, Total_Amount__c,
                       Check_number__c, ChekIns_Total__c, Tickets_Quantty__c, Item_Quantity__c, customer_key__c, 
                       TicketTypes__r.TT_Name__c, TicketTypes__r.TT_Amount__c, TicketTypes__r.TT_TicketType__c, TicketTypes__r.TT_Available__c, 
                       Item__r.Item_name__c, Item__r.Item_Quantity__c, Item__r.Cost__c, Available_Quantity__c,
                       Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c, Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c, 
                       Event_Attendee_Mapping__r.AS_id__r.AS_Company__c, Event_Attendee_Mapping__r.AS_id__r.AS_Email__c 
                       FROM Dummay__c 
                       WHERE Available_Quantity__c != 0 AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE AND Event__c =: SelectedEventId AND 
                       (TicketTypes__c != NULL OR Item__c != NULL ) AND customer_key__r.Isinserted__c =: TRUE
                       ORDER BY customer_key__r.CreatedDate DESC];
        
         SET<Id> CustIds= new SET<Id>();
         for(Dummay__c reg: RegInfosList){
             CustIds.add(reg.customer_key__c);
         }
         
         OrdersList=[SELECT ID, Name,Customer_Name__c, Email__c, Isinserted__c, Total_Amount__c, 
                    (SELECT ID, DiscountValue__c, TicketTypes__c, First_Name__c, TicketAmount__c, Last_Name__c, 
                     Email__c, Company__c, Registered_Date__c, Payment_Status__c, Payment_Type__c, Phone__c, Amount__c, Total_Amount__c,
                     Check_number__c, ChekIns_Total__c, Tickets_Quantty__c, Item_Quantity__c, customer_key__c, 
                     TicketTypes__r.TT_Name__c, TicketTypes__r.TT_Amount__c, TicketTypes__r.TT_TicketType__c, TicketTypes__r.TT_Available__c, 
                     Item__r.Item_name__c, Item__r.Item_Quantity__c, Item__r.Cost__c, Available_Quantity__c,
                     Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c, Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c, 
                     Event_Attendee_Mapping__r.AS_id__r.AS_Company__c, Event_Attendee_Mapping__r.AS_id__r.AS_Email__c 
                     FROM Dummays__r WHERE Available_Quantity__c != 0 AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE AND Event__c =: SelectedEventId AND (TicketTypes__c != NULL OR Item__c != NULL ))
                     FROM Constomer__c
                     WHERE Isinserted__c =: TRUE AND ID IN : CustIds                   
                     ORDER BY CreatedDate DESC];
         system.debug( 'dddddddddddddddddd '+OrdersList.size());  
         //OR (TicketTypes__r.TT_Name__c !=: 'Guest' AND TicketTypes__r.TT_Name__c !=: 'Attendee Staff')
         LIST<orderSalesInner> orderSalesInnerList999= new LIST<orderSalesInner>();
         for(Constomer__c trans: OrdersList){        
            system.debug( '11111111111111111'+trans);  
            LIST<Dummay__c> RegInfoList= new LIST<Dummay__c>();
            RegInfoList= trans.Dummays__r;
            system.debug( 'dddddddddddddddddd '+OrdersList.size());  
            if(RegInfoList.size()>0){
                orderSalesInnerList999.add(new orderSalesInner(trans, RegInfoList));
                if(orderSalesInnerList999.size() == 999){
                    orderSalesInnerList.add(orderSalesInnerList999);
                    orderSalesInnerList999= new LIST<orderSalesInner>();
                }

            }      
        }
        if(orderSalesInnerList999.size() != 0){
            orderSalesInnerList.add(orderSalesInnerList999);
        }
        
        
        

        
        system.debug(orderSalesInnerList.size()+'  ORDERS LIST INNER '+orderSalesInnerList);
        RevenueStatistics();
    }
     
    public void ticketSalesReport(){
    

        TicketTypesForEvent= new LIST<TicketTypes__c>();
        ticketsSalesInnerList= new LIST<ticketsSalesInner>();
        ticketSalesMAP= new MAP<String, LIST<Dummay__c>>();
        ticketNameMAP= new MAP<String, String>();


        
        if(ReportName == 'Report On Ticket Sales'){
            ticketSales= new LIST<Dummay__c>();
            ticketSales= [SELECT Id, DiscountValue__c, TicketTypes__r.TT_TicketType__c,TicketTypes__c, First_Name__c, 
                          Last_Name__c, Email__c, Company__c, Payment_Status__c, Payment_Type__c, Phone__c, 
                          Check_number__c, ChekIns_Total__c, Tickets_Quantty__c, Item_Quantity__c, customer_key__c,
                          customer_key__r.Name, customer_key__r.Total_Amount__c, TicketTypes__r.TT_Name__c, TicketTypes__r.TT_Amount__c, 
                          TicketTypes__r.TT_Available__c, Item__r.Item_name__c, Item__r.Item_Quantity__c, Total_Amount__c,
                          Item__r.Cost__c, TicketAmount__c, Registered_Date__c, Amount__c,Available_Quantity__c,
                          Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c, Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c, 
                          Event_Attendee_Mapping__r.AS_id__r.AS_Company__c, Event_Attendee_Mapping__r.AS_id__r.AS_Email__c 
                          FROM Dummay__c 
                          WHERE Event__c=: selectedEventId AND TicketTypes__c != NULL                          
                          AND Available_Quantity__c !=0]; 
                          
            // AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE AND TicketTypes__r.TT_Name__c != 'Guest'
             //AND TicketTypes__r.TT_Name__c != 'Attendee Staff'                
            if(selectedFilterType == 'Ticket'){
                ticketsSalesInnerList= new LIST<ticketsSalesInner>();
                TicketTypesForEvent= [SELECT ID, TT_Name__c FROM TicketTypes__c WHERE EV_id__c =: selectedEventId];
              
                system.debug(TicketTypesForEvent.size()+'  TICKETS '+ticketSales.size());
                
                for(TicketTypes__c ticket: TicketTypesForEvent){
    
                         LIST<Dummay__c> regList= new LIST<Dummay__c>();
                         for(Dummay__c reg: ticketSales){                    
                            if(ticket.ID == reg.TicketTypes__c){
                                regList.add(reg);
                            }
                            
                            
                            }
                        if(regList.size() >0){
                            ticketsSalesInnerList.add(new ticketsSalesInner(ticket.TT_Name__c, regList));
                        }
                }   
                system.debug(ticketsSalesInnerList.size()+'   PAYMENT TYPE SIZE '+ticketsSalesInnerList);     
             }else if(selectedFilterType== 'Payment Type'){
                    ticketsSalesInnerList= new LIST<ticketsSalesInner>();
                    List<Schema.PicklistEntry> paymentValues= Dummay__c.Payment_Type__c.getDescribe().getPicklistValues();
                    for(Schema.PicklistEntry pk: paymentValues){
                    
                        LIST<Dummay__c> regList= new LIST<Dummay__c>();
                         for(Dummay__c reg: ticketSales){                    
                            if(reg.Payment_Type__c == pk.getValue()){
                                regList.add(reg);
                            }
                            
                            
                            }
                            if(regList.size() >0){
                                ticketsSalesInnerList.add(new ticketsSalesInner(pk.getValue(), regList));
                            }
                    }
                    
                   system.debug(ticketsSalesInnerList.size()+'   PAYMENT TYPE SIZE '+ticketsSalesInnerList);
    
                }else if(selectedFilterType== 'Company'){
                    LIST<Event_Attendee_Mapping__c> EAMList= new LIST<Event_Attendee_Mapping__c>();
                    EAMList=[SELECT ID, AS_id__r.AS_Company__c, (SELECT ID FROM Registration_Info__r)
                             FROM Event_Attendee_Mapping__c
                             WHERE EV_id__c =: SelectedEventId 
                             ];
                               
                    system.debug(EAMList.size()+'   EAM LIST '+EAMList);
                    SET<String> CompanyValues= new SET<String>();
                    
                    for(Event_Attendee_Mapping__c eam: EAMList){
                        LIST<Dummay__c> regList= new LIST<Dummay__c>();
                        regList= eam.Registration_Info__r;
                        if(regList.size() >0){
                            CompanyValues.add(eam.AS_id__r.AS_Company__c);
                        }
                    }
                    for(String Company: CompanyValues){
                        LIST<Dummay__c> regList= new LIST<Dummay__c>();
                         for(Dummay__c reg: ticketSales){                    
                            if( reg.Event_Attendee_Mapping__r.AS_id__r.AS_Company__c != NULL && reg.Event_Attendee_Mapping__r.AS_id__r.AS_Company__c == Company){
                                regList.add(reg);
                            }
                            
                         }
                        if(regList.size() >0){
                            ticketsSalesInnerList.add(new ticketsSalesInner(Company, regList));
                        }
                    }  
                    LIST<Dummay__c> CompanyEmptyList= new LIST<Dummay__c>();
                    for(Dummay__c reg: ticketSales){                    
                            if(reg.Event_Attendee_Mapping__r.AS_id__r.AS_Company__c == NULL){
                                CompanyEmptyList.add(reg);
                            }
                            
                         }
                         
                         if(CompanyEmptyList.size() >0){
                             ticketsSalesInnerList.add(new ticketsSalesInner('None', CompanyEmptyList));
                         }                 
                }
    
            }else if(ReportName=='Report On Item Sales'){
                 ticketSales= new LIST<Dummay__c>();
                 ticketSales= [SELECT Id, DiscountValue__c, TicketTypes__r.TT_TicketType__c,TicketTypes__c, 
                               First_Name__c, Last_Name__c, Email__c, Company__c, Payment_Status__c, Payment_Type__c, 
                               Phone__c, Check_number__c, Tickets_Quantty__c, Item_Quantity__c, customer_key__c, Total_Amount__c, 
                               customer_key__r.Name, customer_key__r.Total_Amount__c, TicketTypes__r.TT_Name__c, TicketTypes__r.TT_Amount__c, 
                               TicketTypes__r.TT_Available__c, Item__r.Item_name__c, Item__r.Item_Quantity__c, Item__r.Cost__c, 
                               TicketAmount__c, Registered_Date__c, Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c, Amount__c,
                               Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c, Event_Attendee_Mapping__r.AS_id__r.AS_Company__c, 
                               Event_Attendee_Mapping__r.AS_id__r.AS_Email__c, Available_Quantity__c
                               FROM Dummay__c 
                               WHERE Event__c=: selectedEventId AND Item__c != NULL
                               AND Available_Quantity__c !=0]; 
                  //AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE
                  system.debug(ticketSales.size()+' ITEM SALES  '+ticketSales);          
                 if(selectedFilterType == 'Item'){
                ticketsSalesInnerList= new LIST<ticketsSalesInner>();
                LIST<Item__c> ItemsForEvent= new LIST<Item__c>();
                ItemsForEvent= [SELECT ID, Item_name__c FROM Item__c WHERE Event__c =: selectedEventId];
              
                system.debug(ItemsForEvent.size()+'  ITEMS '+ItemsForEvent.size());
                
                for(Item__c item: ItemsForEvent){
    
                         LIST<Dummay__c> regList= new LIST<Dummay__c>();
                         for(Dummay__c reg: ticketSales){                    
                            if(item.ID == reg.Item__c){
                                regList.add(reg);
                            }
                            
                            
                            }
                        if(regList.size() >0){
                            ticketsSalesInnerList.add(new ticketsSalesInner(item.Item_name__c, regList));
                        }
                }   
                system.debug(ticketsSalesInnerList.size()+'   PAYMENT TYPE SIZE '+ticketsSalesInnerList);     
             }else if(selectedFilterType== 'Payment Type'){
                    ticketsSalesInnerList= new LIST<ticketsSalesInner>();
                    List<Schema.PicklistEntry> paymentValues= Dummay__c.Payment_Type__c.getDescribe().getPicklistValues();
                    for(Schema.PicklistEntry pk: paymentValues){
                    
                        LIST<Dummay__c> regList= new LIST<Dummay__c>();
                         for(Dummay__c reg: ticketSales){                    
                            if(reg.Payment_Type__c == pk.getValue()){
                                regList.add(reg);
                            }
                            
                            
                            }
                            if(regList.size() >0){
                                ticketsSalesInnerList.add(new ticketsSalesInner(pk.getValue(), regList));
                            }
                    }
                    
                   system.debug(ticketsSalesInnerList.size()+'   PAYMENT TYPE SIZE '+ticketsSalesInnerList);
    
                }else if(selectedFilterType== 'Company'){
                    LIST<Event_Attendee_Mapping__c> EAMList= new LIST<Event_Attendee_Mapping__c>();
                    EAMList=[SELECT ID, AS_id__r.AS_Company__c, (SELECT ID FROM Registration_Info__r)
                             FROM Event_Attendee_Mapping__c
                             WHERE EV_id__c =: SelectedEventId 
                             ];
                               
                    system.debug(EAMList.size()+'   EAM LIST '+EAMList);
                    SET<String> CompanyValues= new SET<String>();

                    for(Event_Attendee_Mapping__c eam: EAMList){
                        LIST<Dummay__c> regList= new LIST<Dummay__c>();
                        regList= eam.Registration_Info__r;
                        if(regList.size() >0){
                            CompanyValues.add(eam.AS_id__r.AS_Company__c);
                        }
                    }
                                      system.debug(CompanyValues.size()+' COMPANY VALUES  '+CompanyValues);          
                    for(String Company: CompanyValues){
                        LIST<Dummay__c> regList= new LIST<Dummay__c>();
                         for(Dummay__c reg: ticketSales){                    
                            if(reg.Event_Attendee_Mapping__r.AS_id__r.AS_Company__c != NULL && reg.Event_Attendee_Mapping__r.AS_id__r.AS_Company__c == Company){
                                regList.add(reg);
                            }
                            
                         }
                        if(regList.size() >0){
                            ticketsSalesInnerList.add(new ticketsSalesInner(Company, regList));
                        }
                    } 
                    
                    LIST<Dummay__c> CompanyEmptyList= new LIST<Dummay__c>();
                    for(Dummay__c reg: ticketSales){                    
                            if(reg.Event_Attendee_Mapping__r.AS_id__r.AS_Company__c == NULL){
                                CompanyEmptyList.add(reg);
                            }
                            
                         }
                         
                         if(CompanyEmptyList.size() >0){
                             ticketsSalesInnerList.add(new ticketsSalesInner('None', CompanyEmptyList));
                         }                    
                    system.debug(ticketsSalesInnerList.size()+' ITEM INNER LIST  '+ticketsSalesInnerList);                        
                }
    
            }

    }
    
    public LIST<LIST<Individual_Ticket_Info__c>> CheckInStatusList{get; set;}
    public LIST<LIST<Individual_Ticket_Info__c>> CheckInStatusListtoExport{get; set;}
    
    public void checkInStatusReport(){
        
        ticketsSalesInnerList= new LIST<ticketsSalesInner>();
        orderSalesInnerList= new LIST<LIST<orderSalesInner>>();
        CheckInStatusList= new LIST<LIST<Individual_Ticket_Info__c>>();
        refundsList= new LIST<LIST<Individual_Ticket_Info__c>>();
        CheckinHistoryTicketSessionInnerList= new LIST<CheckinHistoryTicketSessionInner>();
       
        LIST<Individual_Ticket_Info__c> CheckStatusList= new LIST<Individual_Ticket_Info__c>();
        if(SelectedCheckInFilter != 'All'){
        
        CheckStatusList= [SELECT ID, Name, Latest_Date_Time__c, Event_Attendee_Mapping__c, Event_Attendee_Mapping__r.MobileCheckInTime__c, Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c, 
                          Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c, Event_Attendee_Mapping__r.AS_id__r.AS_Email__c, 
                          Event_Attendee_Mapping__r.AS_id__r.AS_Company__c, Scanned_by__c, Seat__c, Registration_Info__r.TicketTypes__c,IsCheckedIn__c,
                          Registration_Info__r.TicketTypes__r.TT_Name__c, Ticket_Session_Mapping__r.Session__r.Session_Name__c,Scanned_by__r.firstname, Scanned_by__r.lastname
                          FROM Individual_Ticket_Info__c
                          WHERE Registration_Info__r.Event__c =: selectedEventId AND Scanned_by__c =: SelectedCheckInFilter AND
                          Registration_Info__r.TicketTypes__c != NULL AND
                          Event_Attendee_Mapping__c != NULL AND IsCancelled__c =: FALSE
                          AND IsCancelled__c =: FALSE
                          AND Is_Input__c =: TRUE
                          ORDER BY Latest_Date_Time__c DESC];
                          
                          //AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE Registration_Info__r.TicketTypes__r.TT_Name__c != 'Guest' AND 
                          //Registration_Info__r.TicketTypes__r.TT_Name__c != 'Attendee Staff' AND
                            
         }else{
          CheckStatusList= [SELECT ID, Name, Latest_Date_Time__c, Event_Attendee_Mapping__c, Event_Attendee_Mapping__r.MobileCheckInTime__c,
                            Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c, Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c, 
                            Event_Attendee_Mapping__r.AS_id__r.AS_Email__c, Event_Attendee_Mapping__r.AS_id__r.AS_Company__c, 
                            Scanned_by__c, Seat__c, Registration_Info__r.TicketTypes__c,IsCheckedIn__c,
                            Registration_Info__r.TicketTypes__r.TT_Name__c, Scanned_by__r.firstname, 
                            Ticket_Session_Mapping__r.Session__r.Session_Name__c,
                            Scanned_by__r.lastname
                            FROM Individual_Ticket_Info__c
                            WHERE Registration_Info__r.Event__c =: selectedEventId AND
                            Registration_Info__r.TicketTypes__c != NULL AND
                            Event_Attendee_Mapping__c != NULL
                            AND IsCancelled__c =: FALSE
                            AND Is_Input__c =: TRUE
                            ORDER BY Latest_Date_Time__c DESC];
                            //AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE
         
         }
                            
        // AND (Scanned_by__c =: SelectedCheckInFilter OR Owner.Id=: UserInfo.getUserid())
        LIST<Individual_Ticket_Info__c> CheckStatusList999= new LIST<Individual_Ticket_Info__c>();        
        for(Individual_Ticket_Info__c ind: CheckStatusList){

                CheckStatusList999.add(ind);
                if(CheckStatusList999.size() ==999){
                    CheckInStatusList.add(CheckStatusList999);
                    CheckStatusList999= new LIST<Individual_Ticket_Info__c>();
                }
        
        }
        if(CheckStatusList999.size() != 0){
            CheckInStatusList.add(CheckStatusList999);
            CheckStatusList999= new LIST<Individual_Ticket_Info__c>();
        }
        
        }
    
    
    public LIST<ticketsSalesInner> revenueInnerListToExport{get; set;}
    public LIST<ticketsSalesInner> ticketsSalesInnerList{get; set;}
    
    public class ticketsSalesInner{
        
        public String FilterData{get; set;}
        public LIST<Dummay__c> regData{get; set;}
        
        
        public ticketsSalesInner(String FilterData, LIST<Dummay__c> regData){
        
            this.FilterData= FilterData;
            this.regData= regData;
        
        }
    }
     
     public LIST<LIST<orderSalesInner>> orderSalesInnerList{get; set;}
     public class orderSalesInner{
        
        public Constomer__c OrderInfo{get; set;}
        public LIST<Dummay__c> regList{get; set;}
                
        public orderSalesInner(Constomer__c OrderInfo, LIST<Dummay__c> regList){
        
            this.OrderInfo= OrderInfo;
            this.regList= regList;
        
        }
    }
    
    public LIST<orderSalesInner> orderSalesInnerListToExport{get; set;}
    public LIST<LIST<Individual_Ticket_Info__c>> refundsListToExport{get; set;}
    
    public PageReference exportIntoCSV(){
         pagereference pg;
        try{
        
        system.debug('CheckInStatusList:CheckInStatusList:::::' + CheckInStatusList);
        
       
        if(ticketsSalesInnerList.size() >0){
            revenueInnerListToExport= new LIST<ticketsSalesInner>();
            for(ticketsSalesInner inn: ticketsSalesInnerList){
                LIST<Dummay__c> regInfo= new LIST<Dummay__c>();
                regInfo= inn.regData;
                for(Dummay__c reg: regInfo){
                
                    reg.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c = escape(reg.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c);
                    reg.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c = escape(reg.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c);                
                    reg.Event_Attendee_Mapping__r.AS_id__r.AS_Email__c = escape(reg.Event_Attendee_Mapping__r.AS_id__r.AS_Email__c);                
                    if(reg.TicketTypes__c != NULL){
                        reg.TicketTypes__r.TT_Name__c = escape(reg.TicketTypes__r.TT_Name__c);                                   
                        reg.TicketTypes__r.TT_TicketType__c = escape(reg.TicketTypes__r.TT_TicketType__c);                                   
                    }
                    if(reg.Item__c != NULL){
                        reg.Item__r.Item_name__c = escape(reg.Item__r.Item_name__c); 
                    }                                  

                    
                }
                revenueInnerListToExport.add(new ticketsSalesInner(inn.FilterData, regInfo));
            } 
            pg =page.SA_ExportReports;
            
            }else if(CheckInStatusList.size() >0){
                CheckInStatusListtoExport= new LIST<LIST<Individual_Ticket_Info__c>>();
                
        
                for(LIST<Individual_Ticket_Info__c> indu : CheckInStatusList){
                    LIST<Individual_Ticket_Info__c> indList= new LIST<Individual_Ticket_Info__c>();
                    for(Individual_Ticket_Info__c ind:indu){
                        if(ind.Event_Attendee_Mapping__c!= NULL){
                            ind.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c= escape(ind.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c);
                            ind.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c= escape(ind.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c);
                            ind.Event_Attendee_Mapping__r.AS_id__r.AS_Email__c= escape(ind.Event_Attendee_Mapping__r.AS_id__r.AS_Email__c);
                            ind.Event_Attendee_Mapping__r.AS_id__r.AS_Company__c= escape(ind.Event_Attendee_Mapping__r.AS_id__r.AS_Company__c);
                            ind.Event_Attendee_Mapping__r.MobileCheckInTime__c= escape(ind.Event_Attendee_Mapping__r.MobileCheckInTime__c);                        
                        
                        }
                        if(ind.Registration_Info__r.TicketTypes__c != NULL){
                            ind.Registration_Info__r.TicketTypes__r.TT_Name__c= escape(ind.Registration_Info__r.TicketTypes__r.TT_Name__c);                    
                        }
                        if(ind.Scanned_by__c != NULL){
                            ind.Scanned_by__r.lastname= escape(ind.Scanned_by__r.lastname);  
                            ind.Scanned_by__r.firstname= escape(ind.Scanned_by__r.firstname);                    
                        }
                        indList.add(ind);
                    }
                    CheckInStatusListtoExport.add(indList);
                }
                pg =page.SA_ExportReports;     
            }
         
            else if(orderSalesInnerList.size() >0 ){
               
                orderSalesInnerListToExport= new LIST<orderSalesInner>();
                for(LIST<orderSalesInner> OrderSales: orderSalesInnerList){
                    for(orderSalesInner order:OrderSales){
                    Constomer__c trans= order.OrderInfo;
                    LIST<Dummay__c> regInfo= new LIST<Dummay__c>();
                    regInfo= order.regList;
                    for(Dummay__c reg: regInfo){
                    
                        reg.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c= escape(reg.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c);                                            
                        reg.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c= escape(reg.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c);                                                                
                        if(reg.TicketTypes__c != NULL){
                            reg.TicketTypes__r.TT_Name__c= escape(reg.TicketTypes__r.TT_Name__c);                                            
                        }
                        if(reg.Item__c != NULL){
                            reg.Item__r.Item_name__c= escape(reg.Item__r.Item_name__c);                                            
                        }
                    
                    }
                    
                    orderSalesInnerListToExport.add(new orderSalesInner(trans,regInfo));
                      pg =page.SA_ExportReports;
                }
                } 
                 
            }
        
        else if(refundsList.size() >0){
                 refundsListToExport= new LIST<LIST<Individual_Ticket_Info__c>>();
                 
                 for(LIST<Individual_Ticket_Info__c> indu : refundsList){
                    LIST<Individual_Ticket_Info__c> indList= new LIST<Individual_Ticket_Info__c>();
                    for(Individual_Ticket_Info__c ind:indu){
                        if(ind.Event_Attendee_Mapping__c!= NULL){
                            ind.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c= escape(ind.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c);
                            ind.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c= escape(ind.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c);
                        
                        }
                        if(ind.Registration_Info__r.TicketTypes__c != NULL){
                            ind.Registration_Info__r.TicketTypes__r.TT_Name__c= escape(ind.Registration_Info__r.TicketTypes__r.TT_Name__c);                    
                        }
                        if(ind.Registration_Info__r.Item__c != NULL){
                            ind.Registration_Info__r.Item__r.Item_name__c= escape(ind.Registration_Info__r.Item__r.Item_name__c);                    
                        }
                       
                        indList.add(ind);
                    }
                    refundsListToExport.add(indList);
                }
                    pg =page.SA_ExportReports;
            } else if(SelectedCheckInHistoryType == 'Guest' && CheckInHistoryInnerList.size() >0 && ShowCHForAttendee == TRUE){
                CheckInHistoryInnerListToExport= new LIST<CheckInHistoryInner> ();
                
                for(CheckInHistoryInner checkinhistory: CheckInHistoryInnerList){
                    LIST<User_CheckinHistory__c> updateCheckInHistoryList= new LIST<User_CheckinHistory__c>();
                    LIST<User_CheckinHistory__c> EAMCheckInHistoryList= new LIST<User_CheckinHistory__c>();
                    EAMCheckInHistoryList= checkinhistory.CheckInHistoryData;
                    checkinhistory.EAMData.AS_ID__r.AS_FirstName__c= escape(checkinhistory.EAMData.AS_ID__r.AS_FirstName__c);
                    checkinhistory.EAMData.AS_ID__r.AS_LastName__c= escape(checkinhistory.EAMData.AS_ID__r.AS_LastName__c);
                    
                    for(User_CheckinHistory__c CheckIn: EAMCheckInHistoryList){
                        CheckIn.Individual_Ticket_Info__r.Registration_Info__r.TicketTypes__r.TT_Name__c= escape(CheckIn.Individual_Ticket_Info__r.Registration_Info__r.TicketTypes__r.TT_Name__c);
                        if(CheckIn.Individual_Ticket_Info__r.Ticket_Session_Mapping__c != NULL){
                            CheckIn.Individual_Ticket_Info__r.Ticket_Session_Mapping__r.Session__r.Session_Name__c= escape(CheckIn.Individual_Ticket_Info__r.Ticket_Session_Mapping__r.Session__r.Session_Name__c);                    
                        }
                        CheckIn.UC_CheckinTime__c= escape(CheckIn.UC_CheckinTime__c);
                        CheckIn.CheckoutTime__c= escape(CheckIn.CheckoutTime__c);
                        updateCheckInHistoryList.add(CheckIn);
                    }
                    CheckInHistoryInnerListToExport.add(new CheckInHistoryInner(checkinhistory.EAMData, updateCheckInHistoryList));
                }
            system.debug(CheckInHistoryInnerListToExport.size()+' CHECKIN HISTORY '+CheckInHistoryInnerListToExport);
                pg =page.SA_ExportReports;
            } else if(ShowCHForTicket == TRUE && SelectedCheckInHistoryType == 'Ticket'){

                CheckinHistoryTicketSessionInnerListExport= new LIST<CheckinHistoryTicketSessionInner>();
                if(WithSessions == TRUE){
                for(CheckinHistoryTicketSessionInner inn: CheckinHistoryTicketSessionInnerList){
                    TicketTypes__c Ticket= inn.TicketData;
                    LIST<SessionCheckinHistoryInner> SessionInnerExport= new LIST<SessionCheckinHistoryInner>();                    
                    LIST<SessionCheckinHistoryInner> SessionInner= inn.SessionInnerData;
                    Ticket.TT_Name__c= escape(Ticket.TT_Name__c); 

                        if(SessionInner.size() >0){                   
                            for(SessionCheckinHistoryInner session: SessionInner){
                                Ticket_Session_Mapping__c SessionName= session.SessionData;
                                system.debug(' SESSION NAME '+SessionName );
                                
                                    if(SessionName.Session__r.Session_Name__c != NULL){
                                        SessionName.Session__r.Session_Name__c= escape(SessionName.Session__r.Session_Name__c); 
                                    }
                                    LIST<User_CheckinHistory__c> CheckInHistory= session.CheckInHistoryData;
                                    for(User_CheckinHistory__c checkin: CheckInHistory){
                                
                                    checkin.UC_CheckinTime__c= escape(checkin.UC_CheckinTime__c);
                                    if(checkin.CheckoutTime__c != NULL){
                                        checkin.CheckoutTime__c= escape(checkin.CheckoutTime__c);
                                    } 
                                    checkin.Individual_Ticket_Info__r.Registration_Info__r.TicketTypes__r.TT_Name__c= escape(checkin.Individual_Ticket_Info__r.Registration_Info__r.TicketTypes__r.TT_Name__c);
                                    checkin.Individual_Ticket_Info__r.Event_Attendee_Mapping__r.AS_ID__r.AS_FirstName__c= escape(checkin.Individual_Ticket_Info__r.Event_Attendee_Mapping__r.AS_ID__r.AS_FirstName__c);
                                    checkin.Individual_Ticket_Info__r.Event_Attendee_Mapping__r.AS_ID__r.AS_LastName__c= escape(checkin.Individual_Ticket_Info__r.Event_Attendee_Mapping__r.AS_ID__r.AS_LastName__c);                             
                                }
                                SessionInnerExport.add(new SessionCheckinHistoryInner(SessionName, CheckInHistory)); 
                                                                         
                                
                            }
                            CheckinHistoryTicketSessionInnerListExport.add(new CheckinHistoryTicketSessionInner(Ticket,SessionInnerExport));
                         }   
                    }
                }else if(WithoutSessions == TRUE){
                        CheckInHistoryTicketInnerListExport= new LIST<CheckInHistoryTicketInner>();

                        for(CheckInHistoryTicketInner inne: CheckInHistoryTicketInnerList){
                            TicketTypes__c tic= inne.TicketData;
                            tic.TT_Name__c= escape(tic.TT_Name__c);
                            LIST<User_CheckinHistory__c> checkInHistoryForTicket= new LIST<User_CheckinHistory__c>();
                            checkInHistoryForTicket= inne.CheckInHistoryData;   
                            for(User_CheckinHistory__c check: checkInHistoryForTicket){
                                check.UC_CheckinTime__c= escape(check.UC_CheckinTime__c);
                                if(check.CheckoutTime__c != NULL){
                                    check.CheckoutTime__c= escape(check.CheckoutTime__c);
                                } 
                                check.Individual_Ticket_Info__r.Registration_Info__r.TicketTypes__r.TT_Name__c= escape(check.Individual_Ticket_Info__r.Registration_Info__r.TicketTypes__r.TT_Name__c);
                                check.Individual_Ticket_Info__r.Event_Attendee_Mapping__r.AS_ID__r.AS_FirstName__c= escape(check.Individual_Ticket_Info__r.Event_Attendee_Mapping__r.AS_ID__r.AS_FirstName__c);
                                check.Individual_Ticket_Info__r.Event_Attendee_Mapping__r.AS_ID__r.AS_LastName__c= escape(check.Individual_Ticket_Info__r.Event_Attendee_Mapping__r.AS_ID__r.AS_LastName__c);                             
                               
                            }
                            CheckInHistoryTicketInnerListExport.add(new CheckInHistoryTicketInner(tic,checkInHistoryForTicket));
                        }                       
                    }         
            }    
           }catch(Exception e){}   
            pg =page.SA_ExportReports;
        return pg;
             
    }
    public LIST<CheckinHistoryTicketSessionInner> CheckinHistoryTicketSessionInnerListExport{get; set;}    
        public LIST<CheckInHistoryTicketInner> CheckInHistoryTicketInnerListExport{get; set;}    
     public PageReference PrintReport() {  
        PageReference pg;
        pg =page.SA_PrintReports;
        return pg;
    }

   
    public string escape(string s){
        if(s != null && s.contains(',')){  
        s=s.replaceAll(',','');
        //s='"'+s+'"';
        } 
        return s;
    }


//-------------------------------------------------------- CheckIn History Start -------------------------------------------------
    
    
    public LIST<Individual_Ticket_Info__c> IndInfoList{get; set;}
    public LIST<User_CheckinHistory__c> CheckInHistoryList{get; set;}
    public LIST<Event_Attendee_Mapping__c> EAMList{get; set;}
    public Boolean ShowCHForAttendee{get; set;}
    public Boolean ShowCHForTicket{get; set;}
    public LIST<SelectOption> CheckInHistoryTypes{get; set;}
    public String SelectedCheckInHistoryType{get; set;}
    public LIST<TicketTypes__c> TicketTypesList{get; set;}
    public LIST<CheckInHistoryInner> CheckInHistoryInnerListToExport{get; set;}
        
    public void CheckInHistoryReport(){
    
        ShowOrderSales= FALSE;
        ShowItemSales= FALSE;
        ShowTicketSales= FALSE;
        ShowCheckInStatus= FALSE;
        ShowRefundList= FALSE;
        
        CheckInHistoryTypes= new LIST<SelectOption>();
        CheckInHistoryTypes.add(new Selectoption('Guest','Guest'));
        CheckInHistoryTypes.add(new Selectoption('Ticket','Ticket'));    
        SelectedCheckInHistoryType= 'Guest';
            
        ReportName='Report On CheckIn History';
        
        ticketsSalesInnerList= new LIST<ticketsSalesInner>();
        orderSalesInnerList= new LIST<LIST<orderSalesInner>>();
        CheckInStatusList= new LIST<LIST<Individual_Ticket_Info__c>>();
        refundsList= new LIST<LIST<Individual_Ticket_Info__c>>();
        CheckinHistoryTicketSessionInnerList= new LIST<CheckinHistoryTicketSessionInner>();
        CheckInHistory();
    }
    public LIST<CheckInHistoryTicketInner> CheckInHistoryTicketInnerList{get; set;}
    public Boolean WithSessions{get; set;}
    public Boolean WithoutSessions{get; set;}
    
    public void CheckInHistory(){
            
            IndInfoList= new LIST<Individual_Ticket_Info__c>();
            CheckInHistoryList= new LIST<User_CheckinHistory__c>();
            EAMList= new LIST<Event_Attendee_Mapping__c>();
            CheckInHistoryInnerList= new LIST<CheckInHistoryInner>();
            TicketTypesList= new LIST<TicketTypes__c> ();
            SessionCheckinHistoryInnerList= new LIST<SessionCheckinHistoryInner>();
            CheckInHistoryTicketInnerList= new LIST<CheckInHistoryTicketInner>();
            CheckinHistoryTicketSessionInnerList= new LIST<CheckinHistoryTicketSessionInner>();
                
            if(SelectedCheckInHistoryType == 'Guest'){               
                
                ShowCHForAttendee= TRUE;
                ShowCHForTicket= FALSE;
                EAMList=[SELECT ID, AS_ID__r.AS_FirstName__c, AS_ID__r.AS_LastName__c, AS_ID__r.AS_Company__c, 
                         AS_ID__r.AS_Title__c, AS_ID__r.AS_Email__c
                         FROM Event_Attendee_Mapping__c
                         WHERE EV_id__c =: SelectedEventId
                         AND Is_CheckedIn__c =: TRUE
                         ORDER BY AS_ID__r.AS_LastName__c, AS_ID__r.AS_FirstName__c];
                 //IsCancelled__c =: FALSE        
                system.debug(EAMList.size()+' EAM LIST '+EAMList);
                CheckInHistoryList= [SELECT ID, UC_CheckinTime__c, CheckoutTime__c, UC_CheckinDate__c,
                                     Individual_Ticket_Info__r.Event_Attendee_Mapping__c, 
                                     Individual_Ticket_Info__r.Registration_Info__r.TicketTypes__r.TT_Name__c,
                                     Individual_Ticket_Info__r.Ticket_Session_Mapping__r.Session__r.Session_Name__c,
                                     Individual_Ticket_Info__r.Name
                                     FROM User_CheckinHistory__c 
                                     WHERE Individual_Ticket_Info__r.Event_Attendee_Mapping__c IN :EAMList AND
                                     Individual_Ticket_Info__r.Event_Attendee_Mapping__r.EV_id__c =: SelectedEventId 
                                     ORDER BY Individual_Ticket_Info__r.Name];
                 //Individual_Ticket_Info__r.Event_Attendee_Mapping__r.IsCancelled__c =: FALSE 
                //Individual_Ticket_Info__r.Registration_Info__r.TicketTypes__r.TT_Name__c != 'Guest' AND
                //Individual_Ticket_Info__r.Registration_Info__r.TicketTypes__r.TT_Name__c != 'Attendee Staff' AND 
               // Individual_Ticket_Info__r.IsCheckedIn__c =: TRUE AND
               system.debug(CheckInHistoryList.size()+' CHECK IN HISTORY LIST '+CheckInHistoryList);         
               for(Event_Attendee_Mapping__c EAM: EAMList){
                   LIST<User_CheckinHistory__c> EAMCheckInHistoryList= new LIST<User_CheckinHistory__c>();
                   for(User_CheckinHistory__c CheckIn: CheckInHistoryList){
                       if(CheckIn.Individual_Ticket_Info__r.Event_Attendee_Mapping__c == EAM.ID){
                           system.debug(CheckIn.Individual_Ticket_Info__r.Event_Attendee_Mapping__c+' CHECIN HISTORY DETAILS '+CheckIn.Individual_Ticket_Info__r.Registration_Info__r.TicketTypes__r.TT_Name__c);
                           EAMCheckInHistoryList.add(CheckIn);
                       }
                   }
                   if(EAMCheckInHistoryList.size() >0){
                       CheckInHistoryInnerList.add(new CheckInHistoryInner(EAM, EAMCheckInHistoryList));
                   }
               }
           }else if(SelectedCheckInHistoryType == 'Ticket'){
               ShowCHForAttendee= FALSE;
               ShowCHForTicket= TRUE;               
               
               TicketTypesList=[SELECT ID, TT_Name__c, (SELECT ID, Session__r.Session_Name__c, Session__r.MatchLeads_Date__c FROM Ticket_Session_Mapping__r)
                                FROM TicketTypes__c
                                WHERE EV_id__c =: SelectedEventId
                                ORDER BY TT_Name__c];
                                // AND TT_Name__c != 'Guest' AND TT_Name__c != 'Attendee Staff'];
               system.debug(TicketTypesList.size()+' TICKETS SIZE '+TicketTypesList);
               CheckInHistoryList= [SELECT ID, UC_CheckinTime__c, CheckoutTime__c, UC_CheckinDate__c, 
                                    Individual_Ticket_Info__r.Registration_Info__r.TicketTypes__r.TT_Name__c,
                                    Individual_Ticket_Info__r.Event_Attendee_Mapping__r.AS_ID__r.AS_FirstName__c,
                                    Individual_Ticket_Info__r.Event_Attendee_Mapping__r.AS_ID__r.AS_LastName__c,
                                    Individual_Ticket_Info__r.Ticket_Session_Mapping__r.Session__r.Session_Name__c,
                                    Individual_Ticket_Info__r.Name
                                    FROM User_CheckinHistory__c 
                                    WHERE Individual_Ticket_Info__r.Registration_Info__r.TicketTypes__c IN : TicketTypesList AND
                                    Individual_Ticket_Info__r.Event_Attendee_Mapping__r.EV_id__c =: SelectedEventId AND
                                    Individual_Ticket_Info__r.Event_Attendee_Mapping__r.Is_CheckedIn__c =: TRUE 
                                    ORDER BY Individual_Ticket_Info__r.Name];
                //Individual_Ticket_Info__r.Event_Attendee_Mapping__r.IsCancelled__c =: FALSE AND
               //Individual_Ticket_Info__r.IsCheckedIn__c =: TRUE  AND
              //Individual_Ticket_Info__r.Event_Attendee_Mapping__r.Is_CheckedIn__c =: TRUE AND
              system.debug(CheckInHistoryList.size()+' CHECK IN SIZE '+CheckInHistoryList);
              CheckInHistoryInnerList= new LIST<CheckInHistoryInner>();
              for(TicketTypes__c Tic: TicketTypesList){
              
                  LIST<Ticket_Session_Mapping__c> SessionDates= new LIST<Ticket_Session_Mapping__c>();
                  SessionDates= Tic.Ticket_Session_Mapping__r;
                  SessionCheckinHistoryInnerList= new LIST<SessionCheckinHistoryInner>();
                  system.debug(' SESSION DATES '+SessionDates);
                    if(WithSessions == TRUE){
                          if(SessionDates.size() >0){
                              for(Ticket_Session_Mapping__c sessiondate: SessionDates){
                              
                                  LIST<User_CheckinHistory__c> checkInHistoryForTicketSession= new LIST<User_CheckinHistory__c>();
                                  for(User_CheckinHistory__c checkin: CheckInHistoryList){
                                      system.debug(checkin.Individual_Ticket_Info__r.Registration_Info__r.TicketTypes__c+' INNER 00000000'+Tic.Id);
                                      system.debug(sessiondate.Id+' INNER 222222222'+checkin.Individual_Ticket_Info__r.Ticket_Session_Mapping__c);
                                      if(checkin.Individual_Ticket_Info__r.Registration_Info__r.TicketTypes__c == Tic.Id && sessiondate.Id == checkin.Individual_Ticket_Info__r.Ticket_Session_Mapping__c){
        
                                              checkInHistoryForTicketSession.add(checkin);
                                              system.debug(checkInHistoryForTicketSession.size()+' INNER IF1111111 '+checkInHistoryForTicketSession);
                                        
                                      }
                                  }
                                  if(checkInHistoryForTicketSession.size() >0){
                                      SessionCheckinHistoryInnerList.add(new SessionCheckinHistoryInner(sessiondate, checkInHistoryForTicketSession));
                                  }
                              }
                                  if(SessionCheckinHistoryInnerList.size() >0){
                                      CheckinHistoryTicketSessionInnerList.add(new CheckinHistoryTicketSessionInner(Tic, SessionCheckinHistoryInnerList));                 
                                  }
                                  system.debug(CheckinHistoryTicketSessionInnerList.size()+' PLEASE GET THE DATA'+WithSessions+'  '+WithoutSessions+' 5555555555'+CheckinHistoryTicketSessionInnerList);
                      }else{
                          LIST<User_CheckinHistory__c> checkInHistoryForTicket= new LIST<User_CheckinHistory__c>();
                          for(User_CheckinHistory__c checkin: CheckInHistoryList){
                              if(checkin.Individual_Ticket_Info__r.Registration_Info__r.TicketTypes__c == Tic.Id){
                                  checkInHistoryForTicket.add(checkin);
                                  system.debug(checkInHistoryForTicket.size()+' INNER FOR NOT SESSION  '+checkInHistoryForTicket);
                              }         
                          }
                          if(checkInHistoryForTicket.size() >0){
                              SessionCheckinHistoryInnerList.add(new SessionCheckinHistoryInner( new Ticket_Session_Mapping__c(), checkInHistoryForTicket));
                          }
                          if(SessionCheckinHistoryInnerList.size() >0){
                              CheckinHistoryTicketSessionInnerList.add(new CheckinHistoryTicketSessionInner(Tic, SessionCheckinHistoryInnerList));                 
                          }
                      }
                  }else{
                      
                  CheckInHistoryInnerList=new LIST<CheckInHistoryInner>();
                      system.debug('WITHOUT SESSION 000000  '+CheckInHistoryList.size());
                      LIST<User_CheckinHistory__c> checkInHistoryForTicket= new LIST<User_CheckinHistory__c>();
                      for(User_CheckinHistory__c checkin: CheckInHistoryList){
                          
                          if(checkin.Individual_Ticket_Info__r.Registration_Info__r.TicketTypes__c == Tic.Id){
                              system.debug(Tic.Id+'  WITHOUT SESSION 111111  '+checkin.Individual_Ticket_Info__r.Registration_Info__r.TicketTypes__c);
                              checkInHistoryForTicket.add(checkin);
                              system.debug(checkInHistoryForTicket.size()+'  WITHOUT SESSION DATES '+checkInHistoryForTicket);
                                
                          }
                      }
                          if(checkInHistoryForTicket.size() >0){
                              CheckInHistoryTicketInnerList.add(new CheckInHistoryTicketInner(Tic, checkInHistoryForTicket));
                          }

                  }  
              
               }
                               system.debug(CheckInHistoryTicketInnerList.size()+' CHECK WITHOUT SIZE '+CheckInHistoryTicketInnerList);              
           }
            
    } 
    public LIST<CheckInHistoryInner> CheckInHistoryInnerList{get; set;}
    public Class CheckInHistoryInner{
    
        public Event_Attendee_Mapping__c EAMData{get; set;}
        public LIST<User_CheckinHistory__c> CheckInHistoryData{get; set;}
        
        public CheckInHistoryInner(Event_Attendee_Mapping__c EAMData, LIST<User_CheckinHistory__c> CheckInHistoryData){
            this.EAMData= EAMData;
            this.CheckInHistoryData= CheckInHistoryData;
        }
        
        

    }
    public LIST<CheckinHistoryTicketSessionInner> CheckinHistoryTicketSessionInnerList{get; set;}    
    public class CheckinHistoryTicketSessionInner{
        public TicketTypes__c TicketData{get; set;}
        public LIST<SessionCheckinHistoryInner> SessionInnerData{get; set;}
      
        public CheckinHistoryTicketSessionInner(TicketTypes__c TicketData, LIST<SessionCheckinHistoryInner> SessionInnerData){
            this.TicketData= TicketData;
            this.SessionInnerData= SessionInnerData;
        }
         
    }
    public class CheckInHistoryTicketInner{
        public TicketTypes__c TicketData{get; set;}
        public LIST<User_CheckinHistory__c> CheckInHistoryData{get; set;}
                    
        public CheckInHistoryTicketInner(TicketTypes__c TicketData, LIST<User_CheckinHistory__c> CheckInHistoryData){
            this.TicketData= TicketData;
            this.CheckInHistoryData= CheckInHistoryData;
        }
    }
    
    public LIST<SessionCheckinHistoryInner> SessionCheckinHistoryInnerList{get; set;}
    
    public class SessionCheckinHistoryInner{
        public Ticket_Session_Mapping__c SessionData{get; set;}
        public LIST<User_CheckinHistory__c> CheckInHistoryData{get; set;}
        
        public SessionCheckinHistoryInner(Ticket_Session_Mapping__c SessionData, LIST<User_CheckinHistory__c> CheckInHistoryData){ 
            this.SessionData= SessionData;
            this.CheckInHistoryData= CheckInHistoryData;
        }       
    }
    

//--------------------------------------------------------- CheckIn History End ----------------------------------------------------------------
//--------------------------------------------------------- Refunds List Start----------------------------------------------------------------
    public boolean ShowRefundList{get; set;}
    public LIST<Individual_Ticket_Info__c> refunds{get; set;}
    public LIST<LIST<Individual_Ticket_Info__c>> refundsList{get; set;}
    public Decimal TotalRefundAmount{get; set;}
    
    public void refundsList(){
        
        ShowRefundList= TRUE;
        ShowTicketSales= FALSE;
        ShowItemSales= FALSE;
        ShowCheckInStatus= FALSE;
        ShowOrderSales= FALSE;
        ShowCHForAttendee= FALSE;
        ShowCHForTicket= FALSE;
        
        ticketsSalesInnerList= new LIST<ticketsSalesInner>();
        CheckInStatusList= new LIST<LIST<Individual_Ticket_Info__c>>();
        orderSalesInnerList= new LIST<LIST<orderSalesInner>>();
                
        refunds= new LIST<Individual_Ticket_Info__c>();
        refundsList= new LIST<LIST<Individual_Ticket_Info__c>>();
        
        refunds= [SELECT ID, Registration_Info__r.customer_key__c, Registration_Info__r.customer_key__r.Name, 
                  Registration_Info__r.Name, Refund_Date__c, Refund_Mode__c, 
                  Event_Attendee_Mapping__r.AS_ID__r.AS_FirstName__c, Event_Attendee_Mapping__r.AS_ID__r.AS_LastName__c,
                  Registration_Info__r.TicketTypes__c, Registration_Info__r.TicketTypes__r.TT_Name__c,
                  Registration_Info__r.Item__c, Registration_Info__r.Item__r.Item_name__c, Refund_Amount__c, Amount__c                  
                  FROM Individual_Ticket_Info__c 
                  WHERE Registration_Info__r.Event__c =: SelectedEventId
                  AND IsCancelled__c =: TRUE AND Is_Input__c =: TRUE];
        system.debug(refunds.size()+'   REFUNDS SIZE  '+refunds);
        LIST<AggregateResult> RefundAggregate= new LIST<AggregateResult>();
        RefundAggregate=[SELECT SUM(Refund_Amount__c) s
                         FROM Individual_Ticket_Info__c 
                         WHERE Registration_Info__r.Event__c =: SelectedEventId
                         AND IsCancelled__c =: TRUE AND Is_Input__c =: TRUE];
        TotalRefundAmount=0;
        for(AggregateResult agg: RefundAggregate){
            if((Decimal)agg.get('s') != 0){
                TotalRefundAmount= (Decimal)agg.get('s');
            }
        }                 
        LIST<Individual_Ticket_Info__c> RefundsList999= new LIST<Individual_Ticket_Info__c>();        
        for(Individual_Ticket_Info__c ind: refunds){

                RefundsList999.add(ind);
                if(RefundsList999.size() ==999){
                    refundsList.add(RefundsList999);
                    RefundsList999= new LIST<Individual_Ticket_Info__c>();
                }
        
        }
        if(RefundsList999.size() != 0){
            refundsList.add(RefundsList999);
            RefundsList999= new LIST<Individual_Ticket_Info__c>();
        }
    }
    
    
    

    // -------------------------------------------------------- Refunds Functionality Start ------------------------------------------------------------
    public String OrderIdParam{get; set;}
    public Id SelectedOrderId{get; set;}
    public Id SelectedRegInfoId{get; set;}
    public LIST<Individual_Ticket_Info__c> ITIList{get;set;}
    public Boolean RefundRegPopup{get; set;}
    
    public pagereference showRefundPopUp(){
    
        SelectedOrderId = ApexPages.currentpage().getparameters().get('OrderIdParam'); 
        SelectedRegInfoId = ApexPages.currentpage().getparameters().get('RegIdParam'); 
        RefundRegPopup= TRUE;
        ITIList = new LIST<Individual_Ticket_Info__c>(); 
        refundAmount=0;
        ITIList = [SELECT ID, Name, IsCheckedIn__c,Amount__c,Registration_Info__r.customer_key__c,Refund_Amount__c, IsCancelled__c,
                   Registration_Info__r.TicketTypes__c, Registration_Info__r.Item__c, Registration_Info__r.TicketTypes__r.Name,
                   Registration_Info__r.Item__r.Name, Registration_Info__r.TicketTypes__r.TT_Name__c,Registration_Info__r.payKey__c,
                   Registration_Info__r.Item__r.Item_name__c, Registration_Info__r.Amount__c,Registration_Info__r.Payment_Type__c, 
                   Event_Attendee_Mapping__r.AS_ID__r.AS_FirstName__c, Event_Attendee_Mapping__r.AS_ID__r.AS_LastName__c
                   FROM Individual_Ticket_Info__c
                   WHERE Registration_Info__r.customer_key__c =: SelectedOrderId 
                   AND isCancelled__c =: FALSE AND Is_Input__c =: TRUE AND IsCheckedIn__c =: FALSE
                   ORDER BY NAME];
       system.debug('Refunds List is '+ITIList);

       return null;            
    }
    
    
    public pagereference doRefund(){
    
        Boolean CheckPay = FALSE;
        Integer TicketsCount=0;
        
        MAP<ID, Integer> IncreaseQuantityMAP= new MAP<ID, Integer>();
        LIST<Individual_Ticket_Info__c> updateITI = new LIST<Individual_Ticket_Info__c>();
        
        for(Individual_Ticket_Info__c ind: ITIList){
            Integer IncreaseQuantity= 0;
            
            SYSTEM.DEBUG('ind ind ind' + ind);
            if(ind.IsCancelled__c == TRUE){
                ind.Refund_Date__c= system.now();
                ind.Refund_Mode__c= ind.Registration_Info__r.Payment_Type__c;
                
                updateITI.add(ind);
                if(ind.Registration_Info__r.TicketTypes__c != NULL){
                    if(IncreaseQuantityMAP.containsKey(ind.Registration_Info__r.TicketTypes__c)){
                        IncreaseQuantity= IncreaseQuantityMAP.get(ind.Registration_Info__r.TicketTypes__c);
                    }
                    IncreaseQuantity= IncreaseQuantity+1;
                    IncreaseQuantityMAP.put(ind.Registration_Info__r.TicketTypes__c, IncreaseQuantity);

                }else if(ind.Registration_Info__r.Item__c != NULL){
                    if(IncreaseQuantityMAP.containsKey(ind.Registration_Info__r.Item__c)){
                        IncreaseQuantity= IncreaseQuantityMAP.get(ind.Registration_Info__r.Item__c);
                    }
                    IncreaseQuantity= IncreaseQuantity+1; 
                    IncreaseQuantityMAP.put(ind.Registration_Info__r.Item__c, IncreaseQuantity);               
                }
            }        
        }
        
        try{
        if(ITIList[0].Registration_Info__r.Payment_Type__c == 'Credit Card' && (ITIList[0].Registration_Info__r.payKey__c != NULL || ITIList[0].Registration_Info__r.payKey__c!= '')){
            Decimal TotalChargeAmount = refundAmount*100;
            String stramount = String.valueOf(Integer.valueOf(TotalChargeAmount));
            Stripe request = new Stripe('sk_test_SEppbKiXBACmm9tRsJZkpB8l');
            StripeResponseModel response = request.refundCharge(ITIList[0].Registration_Info__r.payKey__c,stramount);
            if(!response.isError){
                system.debug('Refund ID: ' + response.id);
                CheckPay = TRUE;
            }
            else{
                CheckPay = FALSE;
                system.debug('Error Message :' + response.errorResponse.message);
            }  
        }
        else{
            CheckPay = TRUE;
        }
        if(CheckPay != FALSE){
            Database.update(updateITI, FALSE);
            LIST<TicketTypes__c> UpdateTicketTypesList= new LIST<TicketTypes__c>();
            LIST<Item__c> UpdateItemsList= new LIST<Item__c>();
            
            UpdateTicketTypesList= [SELECT ID, TT_Sold__c FROM TicketTypes__c WHERE ID IN : IncreaseQuantityMAP.keySet()];
            UpdateItemsList= [SELECT ID, Sold_Quantity__c FROM Item__c WHERE ID IN : IncreaseQuantityMAP.keySet()];
            if(UpdateTicketTypesList.size() >0){
                for(TicketTypes__c ticSold: UpdateTicketTypesList){
                    ticSold.TT_Sold__c= ticSold.TT_Sold__c - IncreaseQuantityMAP.get(ticSold.Id);
                }
            }
            if(UpdateItemsList.size() >0){
                for(Item__c itemSold:UpdateItemsList){
                    itemSold.Sold_Quantity__c= itemSold.Sold_Quantity__c - IncreaseQuantityMAP.get(itemSold.Id);
                }
            
            } 
            Database.Update(UpdateTicketTypesList, FALSE);      
            Database.Update(UpdateItemsList, FALSE); 
           
            }
                           
    }catch(Exception e){}
        RefundRegPopup= FALSE;   
        orderSales();     
        return null;
    }

    public void cancelRefund(){
        RefundRegPopup= FALSE;        
    }

    public String SelectedIndId{get; set;}
    public Integer SelectedRefundAmount{get; set;}
    public Decimal refundAmount{get; set;}
    
    public void addRefundAmount(){
        system.debug(' AMOUNT MAP ');
        refundAmount=0;
        for(Individual_Ticket_Info__c ind: ITIList){
        system.debug(ind.Refund_Amount__c +' IS CANCELLED '+ind.IsCancelled__c);
            if(ind.IsCancelled__c == TRUE && ind.Refund_Amount__c != NULL){
                    system.debug('  IF CLASS111111  '+refundAmount);
                refundAmount= refundAmount+ ind.Refund_Amount__c;
                        system.debug(ind.Refund_Amount__c+' IF CLASS22222 '+refundAmount);
            }        
        }
        
        system.debug('  REFUND '+refundAmount);
    }
// ------------------------------------------------------- Refunds Functionality End ----------------------------------------------------------------

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