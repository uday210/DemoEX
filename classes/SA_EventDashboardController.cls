public with sharing class SA_EventDashboardController {

    public String selectedEventId{get; set;}     
    public Event__c SelectedEvent{get; set;}
    public Integer NoofAttendees{get;set;}
    public Integer NoOfTicketsSold{get;set;}
    public Integer NoOfItemsSold{get;set;}
    public Decimal Revenue{get;set;}
    public Integer NoOfcheckins{get;set;}
    public Boolean isPastEvent{get; set;}     
    public Boolean isEventAdminStaffUser{get; set;}   
          
    public SA_EventDashboardController(){
        
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
            Statistics();
            
            ticketSales();
            itemSales();
            checkInStatus();
            paymentstatus();
        }
    }

    public LIST<AggregateResult> TicketRevenue{get; set;}
    public LIST<AggregateResult> itemRevenue{get; set;}    
    public Integer TotalTickets{get; set;}
    public Integer TotalCheckins{get; set;}
    public Integer TotalItems{get; set;}
    public Decimal TicketsRevenue{get; set;}
    public Decimal ItemsRevenue{get; set;}
    public Decimal ExpectedRevenue{get; set;}            
    public Decimal EarnedRevenue{get; set;}       
    public Decimal TicketsPecent{get; set;}
    public Decimal ItemsPercent{get; set;}
    public Decimal CheckedInPercent{get; set;}
    public Decimal RevenuePercent{get; set;}    
    public Decimal TicketRevenuePercent{get; set;}
    public Decimal ItemsRevenuePercent{get; set;}
    

    public void Statistics(){
    
        NoofAttendees = 0;
        NoOfTicketsSold  = 0;
        Revenue = 0; 
        NoOfItemsSold  = 0;
        NoOfcheckins = 0;
        
        TotalTickets= 0;
        TotalCheckins= 0;
        TotalItems= 0;
        TicketsRevenue= 0;
        ItemsRevenue= 0;
                        

        
        AggregateResult [] Attendees= [SELECT COUNT(AS_id__c) 
                                        FROM Event_Attendee_Mapping__c 
                                        WHERE EV_id__c=:selectedEventId];
        
        for (AggregateResult ar : Attendees){
           NoofAttendees =  Integer.valueOf(ar.get('expr0'));
        }
        
        system.debug(' STATISTICS ID '+selectedEventId);    
        
        AggregateResult [] TotalTicketsCount= [SELECT SUM(TT_Available__c) c 
                                               FROM TicketTypes__c
                                               WHERE EV_id__c =:selectedEventId AND TT_Name__c != 'Guest'
                                               AND TT_Name__c != 'Attendee Staff'];
        
        for(AggregateResult  ag: TotalTicketsCount){
        
         if(Integer.valueOf(ag.get('c')) > 0)
                TotalTickets= Integer.valueOf(ag.get('c'));
            else
                TotalTickets= 0;
  
        }
        
        AggregateResult [] TotalItemsCount= [SELECT SUM(Item_Quantity__c) c 
                                               FROM Item__c
                                               WHERE Event__c =:selectedEventId];
        
        for(AggregateResult  ag: TotalItemsCount){
            
            if(Integer.valueOf(ag.get('c')) > 0)
                TotalItems= Integer.valueOf(ag.get('c'));
            else
                TotalItems= 0;
  
        }
        
        AggregateResult [] TotalCheckinsCount= [SELECT COUNT(ID) c 
                                                FROM Individual_Ticket_Info__c
                                                WHERE Registration_Info__r.Event__c =: selectedEventId 
                                                AND Registration_Info__r.TicketTypes__c != NULL 
                                                AND Event_Attendee_Mapping__c != NULL
                                                AND IsCancelled__c =: FALSE
                                                AND Is_Input__c =: TRUE
                                                AND IsItem__c =: FALSE];                          
                                                 
                                                 //WHERE Registration_Info__r.Event__c =: selectedEventId
                                                 //AND IsCancelled__c =: FALSE
                                                 //AND Is_Input__c =: TRUE
                                                 //AND IsItem__c =: FALSE
                                                 //AND Registration_Info__r.TicketTypes__c != NULL
                                                 //AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE];

                                                 //AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE
                                                 //AND Registration_Info__r.TicketTypes__r.TT_Name__c != 'Guest']; 
                                                 //AND Registration_Info__r.TicketTypes__r.TT_Name__c != 'Attendee Staff'];
        
        for(AggregateResult  ag: TotalCheckinsCount){
            
             if(Integer.valueOf(ag.get('c')) > 0)
                TotalCheckins= Integer.valueOf(ag.get('c'));
            else
                TotalCheckins= 0;
  
       
        } 
        
        Decimal ExpectedTicketRevenue=0;
        Decimal ExpectedItemRevenue=0;
        
         AggregateResult [] TicketsRevenueList=  [SELECT SUM(Total_Amount__c) c 
                                                  FROM TicketTypes__c
                                                  WHERE EV_id__c =: selectedEventId
                                                  ];
         
          for(AggregateResult  ag: TicketsRevenueList){
        
             if(Integer.valueOf(ag.get('c')) > 0){
                String ExpectedTicketRevenueString;  
                ExpectedTicketRevenueString= String.valueOf(ag.get('c'));
                ExpectedTicketRevenue= Decimal.valueOf(ExpectedTicketRevenueString);
             }else{
                ExpectedTicketRevenue= 0;
             }
         }
         system.debug(' EXPECTED TICKET REVENUE '+ExpectedTicketRevenue);
         AggregateResult [] ItemsRevenueList=  [SELECT SUM(Total_Amount__c) c 
                                                  FROM Item__c
                                                  WHERE Event__c =: selectedEventId 
                                                  ];
                  
       for(AggregateResult  ag: ItemsRevenueList){
        
             if(Integer.valueOf(ag.get('c')) > 0){
                String ExpectedItemRevenueString; 
                ExpectedItemRevenueString= String.valueOf(ag.get('c'));     
                ExpectedItemRevenue= Decimal.valueOf(ExpectedItemRevenueString);
             }else{
                ExpectedItemRevenue= 0;
             }
         }
                  system.debug(' EXPECTED ITEM REVENUE '+ExpectedItemRevenue);
        ExpectedRevenue= ExpectedTicketRevenue+ExpectedItemRevenue;
                          system.debug(' EXPECTED REVENUE '+ExpectedRevenue);
        
        AggregateResult [] TicketsRevenueCount=  [SELECT SUM(Amount__c) c 
                                                  FROM Dummay__c
                                                  WHERE Event__c=:selectedEventId
                                                  AND TicketTypes__c != NULL
                                                  AND Item__c =: NULL];
                                                  
                                                  //AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE];
        
         for(AggregateResult  ag: TicketsRevenueCount){
        
             if(Integer.valueOf(ag.get('c')) > 0){
                 String TicketsRevenueString;
                 TicketsRevenueString= String.valueOf(ag.get('c'));
                 TicketsRevenue= Decimal.valueOf(TicketsRevenueString);
             }else{
                TicketsRevenue= 0;
             }
         }
        
        AggregateResult [] ItemsRevenueCount=  [SELECT SUM(Amount__c) c 
                                                  FROM Dummay__c
                                                  WHERE Event__c=:selectedEventId
                                                  AND Item__c != NULL];
                                                  
                                                  //AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE];
        
         for(AggregateResult  ag: ItemsRevenueCount){
             
             if(Integer.valueOf(ag.get('c')) > 0){
                 string ItemsRevenueString;
                 ItemsRevenueString= String.valueOf(ag.get('c'));
                ItemsRevenue= Decimal.valueOf(ItemsRevenueString);
             }else{
                ItemsRevenue= 0;
             }

        }
        
        AggregateResult [] RevenueEarned=[SELECT SUM(Amount__c)
                                          FROM Dummay__c
                                          WHERE Event__c=:selectedEventId
                                          AND (TicketTypes__c != NULL OR Item__c != NULL)];
                                          
                                          // OR Item__c != NULL) AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE];
        
        for (AggregateResult ar : RevenueEarned){    
            
            if(Integer.valueOf(ar.get('expr0')) > 0){
                String RevenueString;
                RevenueString= String.valueOf(ar.get('expr0'));
                Revenue=  Decimal.valueOf(RevenueString);
            }else{
                Revenue = 0;
            }
                             
        }
        
        AggregateResult [] CheckedInAgg= [SELECT COUNT(ID)
                                          FROM Individual_Ticket_Info__c
                                          WHERE Registration_Info__r.Event__c =: selectedEventId AND 
                                          Scanned_by__c != NULL AND IsCheckedIn__c =: TRUE AND
                                          Event_Attendee_Mapping__c != NULL
                                          AND IsCancelled__c =: FALSE
                                          AND Is_Input__c =: TRUE
                                          AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE];
                                          
        for(AggregateResult agg: CheckedInAgg){
             if(Integer.valueOf(agg.get('expr0')) > 0)
                NoOfcheckins = Integer.valueOf(agg.get('expr0'));
            else
                NoOfcheckins = 0; 
        }   
   
             
         AggregateResult [] TicketsSold= [SELECT SUM(TT_Sold__c) 
                                         FROM TicketTypes__c
                                         WHERE EV_id__c =: selectedEventId
                                         AND TT_Name__c != 'Guest' 
                                         AND TT_Name__c != 'Attendee Staff'
                                         GROUP BY EV_id__c];        
       
       /* for (AggregateResult ar : TicketsSold){    
            
            if(Integer.valueOf(ar.get('expr0')) > 0)
                NoOfTicketsSold  =  Integer.valueOf(ar.get('expr0'));
            else
                NoOfTicketsSold  = 0;
            
        }*/
        
        NoOfTicketsSold  = 0;
        for(Event__c eves : [Select id,(select id,name,Amount__c,customer_key__r.isInserted__c,Tickets_Quantty__c,For_Refund__c from Dummays__r where customer_key__r.isInserted__c=true and TicketTypes__r.TT_Name__c!='Guest' and TicketTypes__r.TT_Name__c!='Attendee Staff') from Event__c  where id =:selectedEventId]){
             
                 for(Dummay__c d1: eves.Dummays__r){
                    if(null != d1.Tickets_Quantty__c){
                       NoOfTicketsSold  += integer.ValueOf(d1.Tickets_Quantty__c);
                    }
               } 
                   
           }
        
        AggregateResult [] ItemsSold=[SELECT SUM(Available_Quantity__c) 
                                      FROM Dummay__c
                                      WHERE Event__c=:selectedEventId
                                      AND Item__c != NULL];
                                      //AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE];
        
        for (AggregateResult ar : ItemsSold){    
            
            if(Integer.valueOf(ar.get('expr0')) > 0)
                NoOfItemsSold =  Integer.valueOf(ar.get('expr0'));
            else
                NoOfItemsSold = 0;
               
        }
        
             
        ticketStatisticsInnerList= new LIST<ticketStatisticsInner>();
        itemStatisticsInnerList= new LIST<itemStatisticsInner>();
        checkinStatisticsInnerList= new LIST<checkinStatisticsInner>();
        
        if(TotalTickets !=0 || NoOfTicketsSold !=0){
            ticketStatisticsInnerList.add(new ticketStatisticsInner('Total', TotalTickets));
            ticketStatisticsInnerList.add(new ticketStatisticsInner('Sold', NoOfTicketsSold));
        }
        
        TicketsPecent=0;
        if(TotalTickets !=0 && NoOfTicketsSold !=0){
            TicketsPecent= (NoOfTicketsSold*100)/TotalTickets;
            TicketsPecent= TicketsPecent.setscale(2);
        }
        system.debug(TotalTickets+' TOTAL TICKETS '+NoOfTicketsSold+'    '+TicketsPecent);
        if(NoOfItemsSold !=0 || TotalItems !=0){
            itemStatisticsInnerList.add(new itemStatisticsInner('Total', TotalItems));
            itemStatisticsInnerList.add(new itemStatisticsInner('Sold', NoOfItemsSold));
        }
        ItemsPercent=0;
        if(NoOfItemsSold !=0 && TotalItems !=0){
            ItemsPercent= (NoOfItemsSold*100)/TotalItems;
            ItemsPercent= ItemsPercent.setscale(2);
        }
        if(NoOfcheckins !=0 || TotalCheckins!=0){
            checkinStatisticsInnerList.add(new checkinStatisticsInner('Total', TotalCheckins));
            checkinStatisticsInnerList.add(new checkinStatisticsInner('CheckedIns', NoOfcheckins));
        }    
        CheckedInPercent=0;
        if(NoOfcheckins !=0 && TotalCheckins!=0){
            CheckedInPercent= (NoOfcheckins*100)/TotalCheckins;
            CheckedInPercent= CheckedInPercent.setscale(2);            
        }


        system.debug(ExpectedRevenue+' EXPECTED REVENUE INNER '+Revenue);
        revenueEarnedInnerList= new LIST<revenueEarnedInner>();
        if(Revenue !=0 || ExpectedRevenue!=0){
            revenueEarnedInnerList.add(new revenueEarnedInner('Expected', ExpectedRevenue));
            revenueEarnedInnerList.add(new revenueEarnedInner('Earned', Revenue));
            //revenueEarnedInnerList.add(new revenueEarnedInner('Revenue', Revenue, ExpectedRevenue));
        }
        RevenuePercent=0;
        if(Revenue !=0 && ExpectedRevenue!=0){
            RevenuePercent= (Revenue*100)/ExpectedRevenue;
            RevenuePercent= RevenuePercent.setscale(2);            
        }

        system.debug(revenueEarnedInnerList.size()+' EXPECTED REVENUE INNER '+revenueEarnedInnerList);
        
        revenueStatisticsInnerList= new LIST<revenueStatisticsInner>();
        //revenueStatisticsInnerList.add(new revenueStatisticsInner('Tickets', Revenue, TicketsRevenue));
        if(TicketsRevenue !=0 || Revenue !=0){
            revenueStatisticsInnerList.add(new revenueStatisticsInner('Tickets', TicketsRevenue));
            revenueStatisticsInnerList.add(new revenueStatisticsInner('Items', ItemsRevenue));  
        }    
        TicketRevenuePercent=0;
        if(TicketsRevenue !=0 && Revenue !=0){
            TicketRevenuePercent= (TicketsRevenue*100)/Revenue;
            TicketRevenuePercent= TicketRevenuePercent.setscale(2);            
        }
        
         ItemsRevenuePercent=0;
        if(ItemsRevenue !=0 && Revenue !=0){
            ItemsRevenuePercent= (ItemsRevenue*100)/Revenue;
            ItemsRevenuePercent= ItemsRevenuePercent.setscale(2);            
        }
        

        
        system.debug(revenueStatisticsInnerList.size()+' REVENUE STATISTICS INNER '+revenueStatisticsInnerList);                          
    }
    public void ticketSales(){
    
    
    
        TicketRevenue= new LIST<AggregateResult>();
        ticketRevenueInnerList= new LIST<ticketRevenueInner>();
         
        TicketRevenue= [SELECT SUM(Amount__c) sum, TicketTypes__c, TicketTypes__r.TT_Name__c tic
                        FROM Dummay__c
                        WHERE Event__c=: selectedEventId AND TicketTypes__c != NULL AND 
                        TicketTypes__r.TT_Name__c != 'Guest' AND TicketTypes__r.TT_Name__c != 'Attendee Staff'
                        AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE
                        GROUP BY TicketTypes__c, TicketTypes__r.TT_Name__c];
        system.debug(TicketRevenue.size()+' AGGREGATE RESULT  '+TicketRevenue);
        
        for(AggregateResult ag: TicketRevenue){
            if((Decimal)ag.get('sum') != 0){
                String TicName= (String)ag.get('tic');
                if(TicName.length() >15){
                    TicName= Ticname.substring(0,14)+' ...';
                }
                ticketRevenueInnerList.add(new ticketRevenueInner(TicName, (Decimal)ag.get('sum')));
            }
        }
    }
    
    public void itemSales(){
    
        itemRevenue= new LIST<AggregateResult>();
        itemRevenueInnerList= new LIST<itemRevenueInner>();
         
        itemRevenue= [SELECT SUM(Amount__c) sum, Item__c, Item__r.Item_name__c item
                        FROM Dummay__c
                        WHERE Event__c=: selectedEventId AND Item__c != NULL
                        AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE
                        GROUP BY Item__c, Item__r.Item_name__c];
        system.debug(itemRevenue.size()+' AGGREGATE RESULT  '+itemRevenue);
        
        
        for(AggregateResult ag: itemRevenue){
            system.debug(' DECIMAL VALUE  '+(Decimal)ag.get('sum'));
            if((Decimal)ag.get('sum') != 0){
                 String ItemName= (String)ag.get('item');
                if(ItemName.length() >15){
                    ItemName= ItemName.substring(0,14)+' ...';
                }
                itemRevenueInnerList.add(new itemRevenueInner(ItemName, (Decimal)ag.get('sum')));
            }
        }
        
        system.debug(itemRevenueInnerList.size()+' ITEM LIST '+itemRevenueInnerList);
    }
    
    
    public LIST<AggregateResult> CheckInStatusList{get; set;}
    public void checkInStatus(){
    
        CheckInStatusList= new LIST<AggregateResult>();
        CheckInStatusList= [SELECT COUNT(ID) c, Registration_Info__r.TicketTypes__c, Registration_Info__r.TicketTypes__r.TT_Name__c tic, IsCheckedIn__c status  
                            FROM Individual_Ticket_Info__c
                            WHERE Registration_Info__r.Event__c =: selectedEventId AND (Registration_Info__r.TicketTypes__c != NULL)
                            AND IsCancelled__c =: FALSE 
                            AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE
                            GROUP BY Registration_Info__r.TicketTypes__c, IsCheckedIn__c, Registration_Info__r.TicketTypes__r.TT_Name__c];
        //AND Registration_Info__r.TicketTypes__r.TT_Name__c != 'Guest'
        // AND Registration_Info__r.TicketTypes__r.TT_Name__c != 'Attendee Staff'
        
        system.debug(CheckInStatusList.size()+' CHECK INS LIST '+CheckInStatusList);
        CheckInInnerList= new LIST<CheckInInner>();
        
        MAP<String, Integer> CheckInMAP= new MAP<String, Integer>();
        MAP<String, Integer> NotCheckInMAP= new MAP<String, Integer>(); 
        SET<String> TicketsSET= new SET<String>(); 
             
        for(AggregateResult agg: CheckInStatusList){
            TicketsSET.add((String)agg.get('tic'));
            system.debug(agg.get('tic')+' TICKET NAME '+agg.get('status')+'   '+agg.get('c'));
            if(agg.get('status') == TRUE){
                CheckInMAP.put((String)agg.get('tic'), (Integer)agg.get('c'));
            }else if(agg.get('status') == FALSE){
                NotCheckInMAP.put((String)agg.get('tic'), (Integer)agg.get('c'));
            }
            
        }
        
        for(String ticket: TicketsSET){
            Integer checkIn= 0;
            Integer notCheckIn= 0;
            if(CheckInMAP.get(ticket) != NULL){
                checkIn= CheckInMAP.get(ticket);
            }
            if(NotCheckInMAP.get(ticket) != NULL){
                notCheckIn= NotCheckInMAP.get(ticket);
            }
            if(checkIn != 0 || notCheckIn != 0){

                if(ticket.length() >15){
                    ticket= ticket.substring(0,14)+' ...';
                }
                CheckInInnerList.add(new CheckInInner(ticket, checkIn, notCheckIn));
            }
        }
    
        system.debug(CheckInInnerList.size()+' CHECK IN INNER '+CheckInInnerList);
    
    }
 
    public LIST<AggregateResult> paymentAggregate{get; set;}
    
    public void paymentstatus(){
    
        paymentAggregate= new LIST<AggregateResult>();    
        paymentAggregate= [SELECT COUNT(ID) c, SUM(Amount__c) s, Payment_Type__c type
                           FROM Dummay__c
                           WHERE Event__c=: selectedEventId AND Payment_Type__c != NULL
                           AND Event_Attendee_Mapping__r.IsCancelled__c =: FALSE
                           GROUP BY Payment_Type__c];
        paymentTypeInnerList= new LIST<paymentTypeInner>();
        
        for(AggregateResult agg: paymentAggregate){
            if((Decimal)agg.get('s') != 0){
                paymentTypeInnerList.add(new paymentTypeInner((String)agg.get('type'), (Decimal)agg.get('s')));
            }
        }
    }
    

    public LIST<ticketStatisticsInner> ticketStatisticsInnerList{get; set;}
    
    public class ticketStatisticsInner{
        
        public String statisticsName{get; set;}
        public Decimal statisticsCount{get; set;}
        
        public ticketStatisticsInner(String statisticsName, Decimal statisticsCount){
            this.statisticsName= statisticsName;
            this.statisticsCount= statisticsCount;
        }
    }
    
    public LIST<itemStatisticsInner> itemStatisticsInnerList{get; set;}

    public class itemStatisticsInner{
        
        public String statisticsName{get; set;}
        public Decimal statisticsCount{get; set;}
        
        public itemStatisticsInner(String statisticsName, Decimal statisticsCount){
            this.statisticsName= statisticsName;
            this.statisticsCount= statisticsCount;
        }
    }
    
    public LIST<checkinStatisticsInner> checkinStatisticsInnerList{get; set;}
    
    public class checkinStatisticsInner{
        
        public String statisticsName{get; set;}
        public Decimal statisticsCount{get; set;}
        
        public checkinStatisticsInner(String statisticsName, Decimal statisticsCount){
            this.statisticsName= statisticsName;
            this.statisticsCount= statisticsCount;
        }
    }

    public LIST<revenueEarnedInner> revenueEarnedInnerList{get; set;}
    public class revenueEarnedInner{

        public String  RevenueType{get; set;}
       // public Integer EarnedRevenue{get; set;}Integer EarnedRevenue, 
        public Decimal ExpectedRevenue{get; set;}
        
        public revenueEarnedInner(String RevenueType, Decimal ExpectedRevenue){                
            this.RevenueType= RevenueType;
            //this.EarnedRevenue= EarnedRevenue;
            this.ExpectedRevenue= ExpectedRevenue;
        
        }
    
    }
    
    

     public LIST<revenueStatisticsInner> revenueStatisticsInnerList{get; set;}
    public class revenueStatisticsInner{
   
        public String revenueStatisticsName{get; set;}
        //public Decimal revenueStatisticsTotalAmount{get; set;}Decimal revenueStatisticsTotalAmount, 
        public Decimal revenueStatisticsAmount{get; set;}
                
        public revenueStatisticsInner(String revenueStatisticsName, Decimal revenueStatisticsAmount){
            
            this.revenueStatisticsName= revenueStatisticsName;
           // this.revenueStatisticsTotalAmount= revenueStatisticsTotalAmount;
            this.revenueStatisticsAmount= revenueStatisticsAmount;            
        
        }
    
    }
    
    
    public LIST<ticketRevenueInner> ticketRevenueInnerList{get; set;}
    public class ticketRevenueInner{
   
        public String TicData{get; set;}
        public Decimal RevenueData{get; set;}
        
        public ticketRevenueInner(String TicData, Decimal RevenueData){
            
            this.TicData= TicData;
            this.RevenueData= RevenueData;
            
        
        }
    
    }
    
    
    public LIST<itemRevenueInner> ItemRevenueInnerList{get; set;}
    public class itemRevenueInner{
    
        public String itemData{get; set;}
        public Decimal itemRevData{get; set;}
        
        public itemRevenueInner(String itemData, Decimal itemRevData){
            
            this.itemData= itemData;
            this.itemRevData= itemRevData;
            system.debug(itemData+' INNER CLASS '+itemRevData);
        
        }
    
    }

    public LIST<CheckInInner> CheckInInnerList{get; set;}
    public class CheckInInner{
    
        public String ticName{get; set;}
        public Integer CheckInCount{get; set;}
        public Integer NotCheckInCount{get; set;}    
            
        public CheckInInner(String ticName, Integer CheckInCount, Integer NotCheckInCount){
            
            this.ticName= ticName;
            this.CheckInCount= CheckInCount;
            this.NotCheckInCount= NotCheckInCount;
            system.debug(ticName+' INNER CLASS '+CheckInCount);
        
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