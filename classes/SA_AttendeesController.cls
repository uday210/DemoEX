public without sharing class SA_AttendeesController{

    public PageReference ExportBadges() {
       pagereference pg;
        pg =page.SA_ExportAttendees;
        return pg;
    }
    
    
    public PageReference ExportIntoCSV(){
    
        
        
        evatids=ApexPages.currentPage().getParameters().get('evatids'); 
         System.debug('evatids '+evatids);
               
        

        

         if(evatids.length() > 0){
            SelectExport=true;            
          
       }else{
             SelectAttendee= TRUE; 
             SelectExport =false;  
       }
       
         
        
        return null;
    }


    public Boolean SelectExport { get; set; }
    
    public PageReference checkUserId() {
        if (userInfo.getUserType() == 'guest') {
            Pagereference pg = new pagereference('/SA_Signup');
            pg.setredirect(true);
            return pg;
        }else{
         getdataforprint();
         getdataforexport();
            return null;
        }
    }
    
    
     public void getdataforexport()
    {
    InnerForExportAttendeeList=new LIST<InnerForExportAttendee> ();
    
     String q = 'SELECT ID, Event_Attendee_Mapping__c, Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c,Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c, Event_Attendee_Mapping__r.AS_id__r.AS_Email__c,Event_Attendee_Mapping__r.AS_id__r.AS_Company__c, Event_Attendee_Mapping__r.AS_id__r.AS_WorkPhone__c,Event_Attendee_Mapping__r.AS_id__r.AS_Title__c, Event_Attendee_Mapping__r.GuestType__c,Event_Attendee_Mapping__r.AS_id__r.AS_WorkAddress1__c, Event_Attendee_Mapping__r.AS_id__r.AS_WorkCity__c,Event_Attendee_Mapping__r.AS_id__r.AS_Work_States__c, Event_Attendee_Mapping__r.AS_id__r.AS_Work_Country__c,Event_Attendee_Mapping__r.AS_id__r.AS_WorkZipCode__c, Event_Attendee_Mapping__r.checkbox_dataTable__c,TicketTypes__c, TicketTypes__r.TT_Name__c, Item__c, Item__r.Item_name__c, Available_Quantity__c, Amount__c, Payment_Status__c,Payment_Type__c, Registered_Date__c, IndividualAmount__c,(SELECT ID, Event_Attendee_Mapping__c FROM Individual_Ticket_Info__r) FROM Dummay__c WHERE Event_Attendee_Mapping__c in (' + evatids+') AND Event__c =\''+SelectedEventId+'\'';
      
         
          transient LIST<Dummay__c> RegInfoList= new LIST<Dummay__c>();
          try{
         RegInfoList= Database.query(q);}catch(Exception e){}
            

            SET<Id> ExistingEAMIds= new SET<Id>();
            if(RegInfoList.size() >0){              

                for(Dummay__c reg:RegInfoList){            
                    integer QuantityCount=0;
                    ExistingEAMIds.add(reg.Event_Attendee_Mapping__c);
                    for(Individual_Ticket_Info__c ind: reg.Individual_Ticket_Info__r){
                        if(ind.Event_Attendee_Mapping__c == reg.Event_Attendee_Mapping__c){
                            QuantityCount++;
                        }
                    }                  
                    reg.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c= escape(reg.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c);
                    reg.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c= escape(reg.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c);
                    reg.Event_Attendee_Mapping__r.AS_id__r.AS_Email__c= escape(reg.Event_Attendee_Mapping__r.AS_id__r.AS_Email__c);
                    reg.Event_Attendee_Mapping__r.AS_id__r.AS_Company__c= escape(reg.Event_Attendee_Mapping__r.AS_id__r.AS_Company__c);
                    reg.Event_Attendee_Mapping__r.AS_id__r.AS_WorkPhone__c= escape(reg.Event_Attendee_Mapping__r.AS_id__r.AS_WorkPhone__c);
                    reg.Event_Attendee_Mapping__r.AS_id__r.AS_WorkAddress1__c= escape(reg.Event_Attendee_Mapping__r.AS_id__r.AS_WorkAddress1__c);
                    reg.Event_Attendee_Mapping__r.AS_id__r.AS_WorkCity__c= escape(reg.Event_Attendee_Mapping__r.AS_id__r.AS_WorkCity__c);                 
                    reg.Event_Attendee_Mapping__r.AS_id__r.AS_Work_States__c= escape(reg.Event_Attendee_Mapping__r.AS_id__r.AS_Work_States__c);                
                    
                    if(reg.TicketTypes__c != NULL){
                        reg.TicketTypes__r.TT_Name__c= escape(reg.TicketTypes__r.TT_Name__c);
                    }
                    if(reg.Item__c != NULL){                                         
                        reg.Item__r.Item_name__c= escape(reg.Item__r.Item_name__c);                     
                    }
                    
                    reg.Payment_Status__c= escape(reg.Payment_Status__c);                     
                    reg.Payment_Type__c= escape(reg.Payment_Type__c);                     
                    system.debug(reg.Event_Attendee_Mapping__r.AS_id__r.AS_Title__c+'  TITLE AND CAT '+reg.Event_Attendee_Mapping__r.GuestType__c);
                    InnerForExportAttendeeList.add(new InnerForExportAttendee(reg.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c, reg.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c, reg.Event_Attendee_Mapping__r.AS_id__r.AS_Email__c, reg.Event_Attendee_Mapping__r.AS_id__r.AS_WorkPhone__c, reg.Event_Attendee_Mapping__r.AS_id__r.AS_Company__c, reg.Event_Attendee_Mapping__r.AS_id__r.AS_Title__c, reg.Event_Attendee_Mapping__r.GuestType__c,reg.Event_Attendee_Mapping__r.AS_id__r.AS_WorkAddress1__c, reg.Event_Attendee_Mapping__r.AS_id__r.AS_WorkCity__c, reg.Event_Attendee_Mapping__r.AS_id__r.AS_Work_States__c, reg.Event_Attendee_Mapping__r.AS_id__r.AS_WorkZipCode__c, reg.TicketTypes__r.TT_Name__c, reg.Item__r.Item_name__c, QuantityCount, reg.IndividualAmount__c*QuantityCount, reg.Payment_Status__c, reg.Payment_Type__c, reg.Registered_Date__c)); 

                 }
           }
           
            transient LIST<Individual_Ticket_Info__c> IndInfoList= new LIST<Individual_Ticket_Info__c>(); 
           q='SELECT ID, Event_Attendee_Mapping__c, Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c,Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c, Event_Attendee_Mapping__r.AS_id__r.AS_Email__c,Event_Attendee_Mapping__r.AS_id__r.AS_Company__c, Event_Attendee_Mapping__r.AS_id__r.AS_WorkPhone__c,Event_Attendee_Mapping__r.AS_id__r.AS_Title__c, Event_Attendee_Mapping__r.GuestType__c,Event_Attendee_Mapping__r.AS_id__r.AS_WorkAddress1__c,Event_Attendee_Mapping__r.AS_id__r.AS_WorkCity__c,Event_Attendee_Mapping__r.AS_id__r.AS_Work_States__c, Event_Attendee_Mapping__r.AS_id__r.AS_Work_Country__c,Event_Attendee_Mapping__r.AS_id__r.AS_WorkZipCode__c, Event_Attendee_Mapping__r.checkbox_dataTable__c,Total_Amount__c, Registration_Info__r.TicketTypes__c, Registration_Info__r.TicketTypes__r.TT_Name__c,Registration_Info__r.Item__c, Registration_Info__r.Item__r.Item_name__c, Registration_Info__r.Available_Quantity__c,Registration_Info__r.Amount__c, Registration_Info__r.Payment_Status__c,Registration_Info__r.Payment_Type__c, Registration_Info__r.Registered_Date__c,Registration_Info__r.Event_Attendee_Mapping__c FROM Individual_Ticket_Info__c  WHERE Event_Attendee_Mapping__c IN ('+ evatids+') AND Registration_Info__r.Event__c =\''+SelectedEventId+'\' AND IsCancelled__c =FALSE AND Is_Input__c =TRUE';           
            try{
         IndInfoList= Database.query(q);}catch(Exception e){}
           
           system.debug(IndInfoList.size()+'  IND INFO LIST'+IndInfoList);
           for(Individual_Ticket_Info__c ind: IndInfoList){
                        system.debug('   INDIVIDUAL  '+ind);
                        if(ind.Event_Attendee_Mapping__c != ind.Registration_Info__r.Event_Attendee_Mapping__c){
                            ind.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c= escape(ind.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c);
                            ind.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c= escape(ind.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c);
                            ind.Event_Attendee_Mapping__r.AS_id__r.AS_Email__c= escape(ind.Event_Attendee_Mapping__r.AS_id__r.AS_Email__c);
                            ind.Event_Attendee_Mapping__r.AS_id__r.AS_Company__c= escape(ind.Event_Attendee_Mapping__r.AS_id__r.AS_Company__c);
                            ind.Event_Attendee_Mapping__r.AS_id__r.AS_WorkPhone__c= escape(ind.Event_Attendee_Mapping__r.AS_id__r.AS_WorkPhone__c);
                            ind.Event_Attendee_Mapping__r.AS_id__r.AS_WorkAddress1__c= escape(ind.Event_Attendee_Mapping__r.AS_id__r.AS_WorkAddress1__c);
                            ind.Event_Attendee_Mapping__r.AS_id__r.AS_WorkCity__c= escape(ind.Event_Attendee_Mapping__r.AS_id__r.AS_WorkCity__c);                 
                            ind.Event_Attendee_Mapping__r.AS_id__r.AS_Work_States__c= escape(ind.Event_Attendee_Mapping__r.AS_id__r.AS_Work_States__c);                
                            
                            if(ind.Registration_Info__r.TicketTypes__c != NULL){
                                ind.Registration_Info__r.TicketTypes__r.TT_Name__c= escape(ind.Registration_Info__r.TicketTypes__r.TT_Name__c);
                            }
                            if(ind.Registration_Info__r.Item__c != NULL){                                         
                                ind.Registration_Info__r.Item__r.Item_name__c= escape(ind.Registration_Info__r.Item__r.Item_name__c);                     
                            }
                            
                            ind.Registration_Info__r.Payment_Status__c= escape(ind.Registration_Info__r.Payment_Status__c);                     
                            ind.Registration_Info__r.Payment_Type__c= escape(ind.Registration_Info__r.Payment_Type__c);                     
                                                system.debug(ind.Event_Attendee_Mapping__r.AS_id__r.AS_Title__c+'  TITLE AND CAT '+ind.Event_Attendee_Mapping__r.GuestType__c);
                            InnerForExportAttendeeList.add(new InnerForExportAttendee(ind.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c, ind.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c, ind.Event_Attendee_Mapping__r.AS_id__r.AS_Email__c, ind.Event_Attendee_Mapping__r.AS_id__r.AS_WorkPhone__c, ind.Event_Attendee_Mapping__r.AS_id__r.AS_Company__c, ind.Event_Attendee_Mapping__r.AS_id__r.AS_Title__c, ind.Event_Attendee_Mapping__r.GuestType__c, ind.Event_Attendee_Mapping__r.AS_id__r.AS_WorkAddress1__c, ind.Event_Attendee_Mapping__r.AS_id__r.AS_WorkCity__c, ind.Event_Attendee_Mapping__r.AS_id__r.AS_Work_States__c, ind.Event_Attendee_Mapping__r.AS_id__r.AS_WorkZipCode__c, ind.Registration_Info__r.TicketTypes__r.TT_Name__c, ind.Registration_Info__r.Item__r.Item_name__c, 1, ind.Total_Amount__c, ind.Registration_Info__r.Payment_Status__c, ind.Registration_Info__r.Payment_Type__c, ind.Registration_Info__r.Registered_Date__c)); 
        
                        }
                    }   
        
    }
    
    
    public void getdataforprint()
    {
       
      
         String q = 'select Id,TicketTypes__c,Attendee_Types__c, AS_id__c,AS_id__r.AS_FirstName__c,EA_AttendeeBarcode__c,checkbox_dataTable__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Email__c,AS_id__r.AS_Company__c,AS_id__r.AS_WorkPhone__c,EV_id__r.EV_EventLogo__c from Event_Attendee_Mapping__c where id in (' + evatids+')';
       System.debug('query '+q);
         
         PrintAttendees = new List<Event_Attendee_Mapping__c>();
         PrintAttendeesList = new List<List<Event_Attendee_Mapping__c>>();
         PrintAttendeesonLeft = new List<Event_Attendee_Mapping__c>();
         PrintAttendeesonRight = new List<Event_Attendee_Mapping__c>();
         
         try{
         PrintAttendees     = Database.query(q);}catch(Exception e){}
         integer i = 0;
         integer count= 0;   
         LIST <Event_Attendee_Mapping__c> attforexport= new LIST <Event_Attendee_Mapping__c> ();      
         for (Event_Attendee_Mapping__c s: PrintAttendees) {
                 count++;
                 system.debug('==============================count===============' + count);
                 attforexport.add(s);
                 if (count == 1000) {
                     system.debug('==============================count===============' + count);
                     PrintAttendeesList.add(attforexport);
                     attforexport = new LIST < Event_Attendee_Mapping__c > ();
                     count = 0;
                 }
             }
             if (count != 0) {
                 PrintAttendeesList.add(attforexport);
             }
             
         for(Event_Attendee_Mapping__c Toseperate : PrintAttendees){
             
           if(math.mod(i, 2) == 0){        
               PrintAttendeesonLeft.add(Toseperate);
               
           } else {
               PrintAttendeesonRight.add(Toseperate);              
           }
             i++;
         }
         
         if(PrintAttendees.size() > 0){
             if(PrintAttendees[0].EV_id__r.EV_EventLogo__c != null){
                 EventLogo = PrintAttendees[0].EV_id__r.EV_EventLogo__c;
                 if(SelectedLogoOption == 'Badge with Logo') 
                 ShowLogo = TRUE;
                
             }else{
             
                 EventLogo  = '';
                 ShowLogo = FALSE;
             
             }
         
         }
    }


    

      public string escape(string s){
        if(s != null && s.contains(',')){  
        //s=s.replaceAll('"','');
        s=s.replaceAll(',','');
        s='"'+s+'"';
        } 
        return s;
    }
    
    public transient LIST<Event_Attendee_Mapping__c> AttendeeListtoExport{get; set;}
    
    public void deleteAttendee(){
        SelectedDeleteId= ApexPages.CurrentPage().getParameters().get('AttendeeIdParam');
        system.debug(' DELETE ID '+SelectedDeleteId);
        if(SelectedDeleteId != NULL){
            Event_Attendee_Mapping__c InactiveId= new  Event_Attendee_Mapping__c ();
            InactiveId=[SELECT ID, AS_Id__c, IsCancelled__c FROM Event_Attendee_Mapping__c WHERE ID =: SelectedDeleteId];
            InactiveId.IsCancelled__c= TRUE;
            Database.update(InactiveId);
            
            LIST<Individual_Ticket_Info__c> indInfoList= new LIST<Individual_Ticket_Info__c>();
            LIST<Individual_Ticket_Info__c> updateIndInfoList= new LIST<Individual_Ticket_Info__c>();
            indInfoList= [SELECT ID, IsCancelled__c, Registration_Info__r.Available_Quantity__c, Registration_Info__r.Payment_Type__c, Registration_Info__r.TicketTypes__c  FROM Individual_Ticket_Info__c WHERE Registration_Info__r.Event__c =: SelectedEventID AND Event_Attendee_Mapping__c =: InactiveId.Id AND (Registration_Info__r.Payment_Type__c =: 'Guest' OR Registration_Info__r.Payment_Type__c =: 'Free') AND IsCancelled__c =: FALSE];
            system.debug(indInfoList.size()+' IND INFO LIST'+indInfoList);
            MAP<Id, Integer> SoldTicketsMAP= new MAP<Id, Integer>();
            for(Individual_Ticket_Info__c ind: indInfoList){
                system.debug(' 000000000000   '+ind);            
                ind.IsCancelled__c = TRUE;
                ind.Refund_Amount__c = 0;
                ind.Refund_Date__c = Datetime.now();
                ind.Refund_Mode__c = ind.Registration_Info__r.Payment_Type__c;
                updateIndInfoList.add(ind);
                system.debug(SoldTicketsMAP.size()+' 11111111   '+SoldTicketsMAP);            
                if(SoldTicketsMAP.containsKey(ind.Registration_Info__r.TicketTypes__c)){
                    Integer SoldTicketQuantity= SoldTicketsMAP.get(ind.Registration_Info__r.TicketTypes__c);
                    SoldTicketQuantity= SoldTicketQuantity+1;
                    SoldTicketsMAP.put(ind.Registration_Info__r.TicketTypes__c, SoldTicketQuantity);
                }else if(! SoldTicketsMAP.containsKey(ind.Registration_Info__r.TicketTypes__c)){
                    SoldTicketsMAP.put(ind.Registration_Info__r.TicketTypes__c, 1);
                }
                system.debug(SoldTicketsMAP.size()+' 222222222  '+SoldTicketsMAP);            
            }
            LIST<TicketTypes__c> ticketsList= new LIST<TicketTypes__c>();
            LIST<TicketTypes__c> updateTicketsList= new LIST<TicketTypes__c>();
            ticketsList= [SELECT ID, TT_Sold__c FROM TicketTypes__c WHERE EV_id__c =: SelectedEventID AND Id IN: SoldTicketsMAP.keySet()];  
            if(ticketsList.size() >0){
                for(TicketTypes__c ticket: ticketsList){
                    ticket.TT_Sold__c= ticket.TT_Sold__c -SoldTicketsMAP.get(ticket.Id);
                    updateTicketsList.add(ticket);            
                }

            } 
            Database.Update(updateIndInfoList, FALSE);
            Database.Update(updateTicketsList, FALSE);                
            
            
            LIST<User_Profile_Event__c> UPEList= new LIST<User_Profile_Event__c>();
            UPEList= [SELECT ID, Attendee_Summary__c, User_id__c,UEP_isActive__c
                  FROM User_Profile_Event__c
                  WHERE Attendee_Summary__c=: InactiveId.AS_Id__c
                  AND EV_id__c =: SelectedEventId 
                  AND UEP_isActive__c =: TRUE
                  AND Profile_id__r.PR_Name__c =: 'EventAdmin Staff'];   
            if(UPEList.size() >0){
                for(User_Profile_Event__c UPE: UPEList){
                    upe.UEP_isActive__c= FALSE;            
                }
            Database.Update(UPEList, FALSE);
            }     


        
            TogetSelectedEvent();
        }
    }
     public String SelectedDeleteId{get; set;} 
     public List<User_Profile_Event__c> ListOfEvents {get;set;}
     public string SelectedEventId  {get;set;}
     public List<selectOption> SelectEvent{get;set;}
     public transient List<Event_Attendee_Mapping__c> DisplayAttendees{get;set;}
     public Event__c SelectedEvent{get;set;}
     public String SelectedPrinter{get;set;}
     public String SelectedLogoOption{get;set;}
     public Boolean SelectPrinterType{get;set;}
     public Boolean AttendeesList{get;set;}
     public List <selectoption > PrinterOptions {get;set;}
     public List <selectoption > LogoOptions {get;set;}
     public Boolean SelectAttendee{get;set;}
    public Boolean isPastEvent{get; set;}     
    public Boolean isEventAdminStaffUser{get; set;}     
     
    public SA_AttendeesController(){
    
         
       Cookie counter = ApexPages.currentPage().getCookies().get('counter');
        if(counter !=null){
            selectedEventId = counter.getValue();
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
        }
   
      system.debug('JJJJJJJ JJJJJJJJJ JJJJJJJJJ'+SelectedEventId  );
      AttendeesList = TRUE;
      SelectAttendee = FALSE;
      EAMId = new LIST<String>();
      AttendeesList = TRUE;
      TogetSelectedEvent(); 
    }
    
    
    public void ClosePopup(){
        SelectPrinterType= FALSE;
        AttendeesList = TRUE;
        SelectExport=false;
        TogetSelectedEvent();
    }
    
    public transient SET<String> EAMIds{get; set;}
    public transient SET<Id> AttendeesToPrint{get; set;}
    
    public void TogetSelectedEvent(){
           
        DisplayAttendees = new List<Event_Attendee_Mapping__c>();
        system.debug('KKKKKKKKKKKK  KKKKKKKKKKK'+SelectedEventId );
        AttendeesToPrint= new SET<Id>();
        
        if(SelectedEventId != null){
        
            LIST<Event_Attendee_Mapping__c> AttendeesList= new LIST<Event_Attendee_Mapping__c>();
            AttendeesList= [SELECT Id, AS_id__c, AS_id__r.AS_FirstName__c, checkbox_dataTable__c, AS_id__r.AS_LastName__c,
                            AS_id__r.AS_Email__c, AS_id__r.AS_WorkPhone__c, AS_id__r.AS_Company__c, AS_id__r.AS_Title__c,
                            AS_id__r.AS_WorkAddress1__c, AS_id__r.AS_WorkCity__c, 
                            AS_id__r.AS_Work_Country__c, AS_id__r.AS_Work_States__c, AS_id__r.AS_WorkZip__c,
                            (SELECT ID, Total_Amount__c, Event_Attendee_Mapping__r.AS_id__r.AS_Email__c, Registration_Info__r.TicketTypes__c FROM Individual_Ticket_Info__r WHERE IsCancelled__c =: FALSE) 
                            FROM Event_Attendee_Mapping__c 
                            WHERE EV_id__c =:SelectedEventId AND IsCancelled__c =: FALSE ];
            AttendeeInnerList= new LIST<LIST<AttendeeInner>>();
            system.debug(AttendeesList.size()+'  ATTENDEES List : ' + AttendeesList);    
            LIST<AttendeeInner> AttendeesList999= new LIST<AttendeeInner>();         
            for(Event_Attendee_Mapping__c EAM: AttendeesList){
                LIST<Individual_Ticket_Info__c> indList= new LIST<Individual_Ticket_Info__c>();
                indList= EAM.Individual_Ticket_Info__r;
                system.debug(EAM+' indList indList : ' + indList);
                
                Boolean FreeAttendee= TRUE;
                if(indList.size() >0){
                    for(Individual_Ticket_Info__c ind: indList){
                        if(ind.Total_Amount__c != 0 || ind.Event_Attendee_Mapping__r.AS_id__r.AS_Email__c == UserInfo.getUserName()){
                            FreeAttendee= FALSE;
                        }
                       
                        if(ind.Registration_Info__r.TicketTypes__c != NULL){
                            AttendeesToPrint.add(EAM.Id);
                        }
                    }
                    AttendeesList999.add(new AttendeeInner(EAM, FreeAttendee));
                    
                    if(AttendeesList999.size() == 999){
                        AttendeeInnerList.add(AttendeesList999);
                        AttendeesList999= new LIST<AttendeeInner>();
                    }
                    
                    system.debug('EAM1111:' + EAM);
                    //DisplayAttendees.add(EAM);
                    system.debug('DisplayAttendees 1111:' + DisplayAttendees);
                }
            }         
            
            if(AttendeesList999.size() != 0){
              system.debug('::::::::::::::::::::::::::::Mythily:::::::::::'+AttendeesList999.size());
              AttendeeInnerList.add(AttendeesList999);
              system.debug('::::::::::::::::::::::::::::Mythily:::::::::::'+AttendeeInnerList);
            }            
       }                      
      
    }
    
     public transient List<Event_Attendee_Mapping__c> PrintAttendees {get;set;}
     public transient List<Event_Attendee_Mapping__c> PrintAttendeesonLeft {get;set;}
     public transient List<Event_Attendee_Mapping__c> PrintAttendeesonRight {get;set;}
     public Boolean ShowLogo {get;set;}
     public string EventLogo {get;set;}
     public transient LIST<String> EAMId{get;set;}
     public transient List<List<Event_Attendee_Mapping__c>> PrintAttendeesList{get; set;}
     
     public pagereference PrintBadges(){
        
        SelectPrinterType= TRUE; 
        
         
         pagereference pg ;

         if(SelectedPrinter == 'Avery 5392 Name badges'){
             pg = page.AS_PrintBadge_5392Label;
             return pg;             
         }else if(SelectedPrinter  == 'Zebra Label'){
             pg= page.SA_Zebralabel;
             return pg;
         }else if(SelectedPrinter  == 'Dymo Label(30856,Single Label)'){
             pg= page.SA_dymolabel;
             return pg;
         }
            return null;
    
    }
    
    public String evatids{get;set;}
    
    public void PrinterTypes(){
    
         SelectAttendee = FALSE;    
         EAMId= new LIST<String>();
         evatids=ApexPages.currentPage().getParameters().get('evatids'); 
        
               
        

        

         if(evatids.length() > 0){

         SelectedLogoOption = 'Badge with Logo';
         
         SelectedPrinter  = 'Avery 5392 Name badges';
         
         SelectPrinterType = TRUE;
        
         AttendeesList = FALSE;

         PrinterOptions = new List <selectoption> ();
         PrinterOptions.add(new selectoption('Select', 'Select'));
         PrinterOptions.add(new selectoption('Zebra Label', 'Zebra Label'));
         PrinterOptions.add(new selectoption('Dymo Label(30856,Single Label)', 'Dymo Label(30856,Single Label)'));
         PrinterOptions.add(new selectoption('Avery 5392 Name badges', 'Avery 5392 Name badges'));
        
        // return option;
        
         LogoOptions = new List < selectoption > ();
         LogoOptions.add(new selectoption('Select', 'Select'));
         LogoOptions.add(new selectoption('Badge with Logo', 'Badge with Logo'));
         LogoOptions.add(new selectoption('Badge without Logo', 'Badge without Logo'));
         
         SelectAttendee = FALSE;
         
       }else{
           SelectAttendee = TRUE;   
       
       }
         
    }
   
 
     public void Cancel(){
         
         EAMId= new LIST<String>();
         
         SelectPrinterType = FALSE;
         
         AttendeesList = TRUE;
         
         SelectAttendee = FALSE;
         
         TogetSelectedEvent();
     
     }
     
     public transient LIST<LIST<AttendeeInner>> AttendeeInnerList{get; set;} 
     public class AttendeeInner{
         public Event_Attendee_Mapping__c EAMData{get; set;}
         public Boolean isFreeAttendee{get; set;}
         
         public AttendeeInner(Event_Attendee_Mapping__c EAMData, Boolean isFreeAttendee){
             this.EAMData= EAMData;
             this.isFreeAttendee= isFreeAttendee;
         }
     }
     
     
     public transient LIST<InnerForExportAttendee> InnerForExportAttendeeList{get; set;}
     public Class InnerForExportAttendee{
         public String FirstName{get; set;}
         public String LastName{get; set;}
         public String EmailId{get; set;}
         public String WorkPhone{get; set;}
         public String Company{get; set;}
         public String JobTitle{get; set;}
         public String AttendeeCategory{get; set;}
         public String Address{get; set;}
         public String City{get; set;}
         public String State{get; set;}
         public Decimal ZipCode{get; set;}
         public String TicketName{get; set;}
         public String ItemName{get; set;}
         public Decimal SoldQty{get; set;}
         public Decimal TotalPrice{get; set;}
         public String PaymentStatus{get; set;}
         public String PaymentType{get; set;}
         public DateTime PaymentDate{get; set;}         
              
         public InnerForExportAttendee(String FirstName, String LastName, String EmailId, String WorkPhone, String Company, String JobTitle, String AttendeeCategory, String Address, String City, String State, Decimal ZipCode, String TicketName, String ItemName, Decimal SoldQty, Decimal TotalPrice, String PaymentStatus, String PaymentType, DateTime PaymentDate){
             this.FirstName= FirstName;
             this.LastName= LastName;
             this.EmailId= EmailId;
             this.WorkPhone= WorkPhone;
             this.Company= Company;
             this.JobTitle= JobTitle;
             this.AttendeeCategory= AttendeeCategory;
             this.Address= Address;
             this.City= City;
             this.State= State;
             this.ZipCode= ZipCode;
             this.TicketName= TicketName;
             this.ItemName= ItemName;
             this.SoldQty= SoldQty;
             this.TotalPrice= TotalPrice;
             this.PaymentStatus= PaymentStatus;
             this.PaymentType= PaymentType;
             this.PaymentDate= PaymentDate;
             
         }                                 
     }
     
    Public Void printbadgefunc(){
    
          String badgeid= Apexpages.Currentpage().getparameters().get('chkArray');
          SYSTEM.DEBUG('CheckedTicketids' + badgeid);    
         List<String> badgeidslist = new List<String>();
          badgeidslist = badgeid.split('-');
           SYSTEM.DEBUG('Checkedbadgeidslist ' + badgeidslist );   
            
    }
    
}