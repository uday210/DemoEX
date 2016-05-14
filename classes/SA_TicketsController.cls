public with sharing class SA_TicketsController{

    // Ticket Variables
    public LIST<LIST<TicketTypes__c>> TicketTypes{get; set;}
    public TicketTypes__c TT{get; set;}
    public Boolean TicketPopUp{get;set;}
    public Boolean AddTicketPopUp{get;set;}
    public Boolean SelectedTicketMode{get;set;}
    public String TicketIdParam{get;set;}
    public String TableHeading{get;set;}
    public Id SelectedTicketId{get;set;}
    public Id SelectedEventId{get;set;}
    public Event__c SelectedEvent{get;set;}
    public transient Blob Logo{get;set;}
    public String LogoName{get;set;}
    public Boolean myDocBool{get; set;}
    public Document mydoc{get;set;}
    public boolean ShowTicketCost{get; set;}
    public MAP<ID, String> SessionNamesMAP{get; set;}
    public Boolean isPastEvent{get; set;}     
    public Boolean isEventAdminStaffUser{get; set;}   
    public LIST<MatchLeads_Days__c> SessionsList{get; set;}
        
    public SA_TicketsController(){
    
        TicketPopUp = TRUE;
        AddTicketPopUp = FALSE;
        myDocBool = FALSE;  
        SelectedTicketMode = FALSE;
        ShowTicketCost= FALSE;
 
        system.debug(TicketPopUp +' POPUPS '+AddTicketPopUp );
        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
        if(counter !=null){

            SelectedEventId  = counter.getValue();
             SelectedEvent= [SELECT  ID, EV_Title__c, EV_HostingLocation__c, EV_HistingAddr1__c, AS_HostingCity__c, 
                            EV_HostingZipcode__c, EV_EventLogo__c, EV_StartDate__c, EV_EndDate__c, EV_HostingState__c,
                            (SELECT ID FROM MatchLeads_Days__r) 
                            FROM Event__c 
                            Where Id=:SelectedEventId];
            
            SessionsList= SelectedEvent.MatchLeads_Days__r;
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
        system.debug(' EVENT ID '+SelectedEventId);
        SelectedSessionIds= new LIST<String>();
        SessionsListPick= new LIST<SelectOption>();
        SessionNamesMAP= new MAP<ID, String>();

                
        SessionsList= new LIST<MatchLeads_Days__c>();
        SessionsList= [SELECT ID, Start_time__c, End_Time__c, MatchLeads_Date__c, Session_Name__c 
                       FROM MatchLeads_Days__c
                       WHERE Event__c =: SelectedEventId];

        for(MatchLeads_Days__c session: SessionsList){
            String SessionDate= String.valueof(session.MatchLeads_Date__c.format());
            SessionsListPick.add(new SelectOption(session.Id, session.Session_Name__c+'  '+SessionDate));
            SessionNamesMAP.put(session.Id, session.Session_Name__c+'/'+String.valueof(session.MatchLeads_Date__c));
        }
        
        ticketsList();
    }
    
    public PageReference ticketsList(){
        try{
        TicketPopUp = true;
        AddTicketPopUp = false;
        ShowTicketError= FALSE;
        system.debug('****** '+SelectedEventId);
        TicketTypes= new LIST<LIST<TicketTypes__c>>();
        LIST<TicketTypes__c> ticketsList= new LIST<TicketTypes__c>();
        
        ticketsList= [SELECT Id,TT_Name__c,EV_id__c,TT_Amount__c,TT_Sold__c,Ticket_Image_URL__c,Ticket_Category__c,
                      Ticket_Description__c,TT_TicketType__c,TT_Available__c, Available__c 
                      FROM TicketTypes__c 
                      WHERE EV_id__r.id =: SelectedEventId AND TT_Name__c != 'Guest' AND TT_Name__c != 'Attendee Staff'];
                       
                       
        LIST<TicketTypes__c> tickets999= new LIST<TicketTypes__c>();
         
         for(TicketTypes__c  tic: ticketsList){
             
                 tickets999.add(tic);
             
             if(tickets999.size() == 999){
                 TicketTypes.add(tickets999);
                 tickets999= new LIST<TicketTypes__c>();
             }
             system.debug('  MBES LIST  '+tickets999.size()+'  '+TicketTypes.size());
         }
         
         if(tickets999.size() != 0){
              TicketTypes.add(tickets999);
         }
         
                        
        }catch(exception ex){}
        return null;
    }
    
    public Boolean ShowTicketError{get; set;}
    public pagereference deleteTicket(){
        
       SelectedTicketId= ApexPages.currentpage().getparameters().get('TicketIdParam');
       ShowTicketError= FALSE;
       system.debug('DELETE ID 222222222222222  '+SelectedTicketId );
       TT = [SELECT Id,TT_Name__c,EV_id__c,TT_Amount__c,TT_Sold__c,Ticket_Image_URL__c,Ticket_Category__c,
             Ticket_Description__c,TT_TicketType__c,TT_Available__c, (SELECT ID FROM Dummays__r WHERE Event__c =: SelectedEventId
             AND Event_Attendee_Mapping__c != NULL)  
             FROM TicketTypes__c 
             WHERE Id =: SelectedTicketId];
       system.debug('DELETE ID 33333333333  '+TT );
       
        LIST<Dummay__c>  RegInfoList= new LIST<Dummay__c>(); 
           RegInfoList=TT.Dummays__r;
           if(RegInfoList.size() >0){
            ShowTicketError= TRUE;               
           }else{
               database.delete(TT);
               TicketPopUp = true;
               AddTicketPopUp = false;
               ticketsList();
           }
       
        return null;
    }

    public void editTicket(){
        TableHeading='Edit Ticket';
        SelectedTicketMode = true;
        TicketPopUp = false;
        AddTicketPopUp = true;
        ShowTicketError= FALSE;
        SelectedSessionIds= new LIST<String>();
        
        SelectedTicketId = ApexPages.currentpage().getparameters().get('TicketIdParam');
        TT = [SELECT Id,TT_Name__c,EV_id__c,TT_Amount__c,TT_Sold__c,Ticket_Image_URL__c,Ticket_Category__c,
              Ticket_Description__c,TT_TicketType__c,TT_Available__c, (SELECT ID, Session__c FROM Ticket_Session_Mapping__r) 
              FROM TicketTypes__c 
              WHERE Id =: SelectedTicketId];
              
        if(TT.TT_TicketType__c == 'Free'){
            ShowTicketCost= FALSE; 
        }else{
            ShowTicketCost= TRUE; 
        }
        
        LIST<Ticket_Session_Mapping__c> TSMList= new LIST<Ticket_Session_Mapping__c>();
        TSMList= TT.Ticket_Session_Mapping__r;
        system.debug(TSMList.size()+' TSM LIST '+TSMList);
        if(TSMList.size() >0){
            for(Ticket_Session_Mapping__c TSM: TSMList){
                SelectedSessionIds.add(TSM.Session__c);         
            }
        
        }

    }
    
    public LIST<SelectOption> SessionsListPick{get; set;}
    public LIST<String> SelectedSessionIds{get; set;}
    
    public void addTicket(){
    
        TableHeading='Add Ticket';
        SelectedTicketMode = true;
        ShowTicketCost= TRUE;
        ShowTicketError= FALSE;
        TicketPopUp = false;
        AddTicketPopUp = true;
        TT = new TicketTypes__c();
        TT.TT_Amount__c=0;
        SelectedSessionIds= new LIST<String>();
    }
    
       
    public String SelectedTicketType{get; set;} 
    
    public void ticketTypeVal(){
        system.debug(apexpages.currentpage().getparameters().get('ticketType')+' SELECTED TICKET TYPE '+SelectedTicketType);
        
        if(SelectedTicketType == 'Free'){
            ShowTicketCost= FALSE; 
            TT.TT_TicketType__c = SelectedTicketType; 
            TT.TT_Amount__c=0;      
        }else{
            ShowTicketCost= TRUE; 
            TT.TT_TicketType__c = SelectedTicketType;       
        }
            
    }
    
    public String SessionNames{get; set;}
        
    public void createTicket(){
        ShowTicketError= FALSE;
        myDocBool = TRUE;       
           if(Logo != null && ( LogoName != '' || LogoName != NULL )){
               if(Logo.size()!= null){
                 
               if(Logo.size() < 1048576 ){
                    mydoc = new document();
                    mydoc.body = Logo;
                    mydoc.folderid = '00lF0000001VI7Y';
                    
                    mydoc.IsPublic = True;
                    mydoc.Name = LogoName;
                    DataBase.saveResult docSaveResult = DataBase.insert(mydoc, false);
        
                    String eventold;
        
                    if(docSaveResult.isSuccess()){
                        if(TT.Ticket_Image_URL__c != null){
                            try{
                            eventold = TT.Ticket_Image_URL__c;          
                            document dd = [SELECT ID, NAME FROM document WHERE id=: eventold];
                            Database.delete(dd);
                            }
                            catch(exception ex){}
                        }
                        String imageURL='';
                        string urlbase =URL.getSalesforceBaseUrl().getHost();
                        string orgId = UserInfo.getOrganizationId();
                    
                        imageURL= 'https://'+urlbase+'/servlet/servlet.ImageServer?oid='+orgId+'&id='+docSaveResult.getId();
                        TT.Ticket_Image_URL__c = docSaveResult.getId();
                    }
                    else{
                        myDocBool = FALSE;
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, String.valueOf(docSaveResult.getErrors()))); 
                    } 
                }
                else{
                    myDocBool = FALSE; 
                }
               }            
         }
         TT.EV_id__c = SelectedEventId;   
         system.debug('&&&& '+TT);
         Database.UpsertResult EventupsertResult= DataBase.Upsert(TT, false);
         system.debug(' SESSION IDS  '+SelectedSessionIds);
         
         LIST<Ticket_Session_Mapping__c> upsertTSMList= new LIST<Ticket_Session_Mapping__c>();
         SessionNames='';
         integer i=0;
         if(SelectedSessionIds.size() >0){
             for(String session: SelectedSessionIds){
             
                 Ticket_Session_Mapping__c insertTSM= new Ticket_Session_Mapping__c();
                 insertTSM.Session__c= session;
                 insertTSM.Ticket__c= TT.Id;
                 insertTSM.Unique_Ids__c= session+'-'+TT.Id;
                 SessionNames= SessionNames+SessionNamesMAP.get(session)+',';
                 if(i ==0){
                     insertTSM.Is_Input__c= TRUE;
                 }   
                 i++;              
                 upsertTSMList.add(insertTSM);
             }
             LIST<Database.UpsertResult> TSMUpsert= DataBase.Upsert(upsertTSMList, Ticket_Session_Mapping__c.Unique_Ids__c, false);         
         
             LIST<Ticket_Session_Mapping__c> deleteTSMList= new LIST<Ticket_Session_Mapping__c>();
             deleteTSMList=[SELECT ID 
                            FROM Ticket_Session_Mapping__c 
                            WHERE Session__c NOT IN : SelectedSessionIds AND
                            Ticket__c =: TT.Id];
                            
             Database.delete(deleteTSMList, FALSE);
             TT.Session_Names__c= SessionNames;
             Database.Update(TT, FALSE);
         }
         TicketPopUp = true;
         AddTicketPopUp = false;
         ticketslist();
    }
    
    public void viewTicket(){
        TableHeading='Ticket Information';
        SelectedTicketMode = false;
        TicketPopUp = false;
        AddTicketPopUp = true;
        SelectedTicketId = ApexPages.currentpage().getparameters().get('TicketIdParam');
        TT = [SELECT Id,TT_Name__c,EV_id__c,TT_Amount__c,TT_Sold__c,Ticket_Image_URL__c,Ticket_Category__c,Ticket_Description__c,TT_TicketType__c,TT_Available__c 
              FROM TicketTypes__c 
              WHERE Id =: SelectedTicketId];
    }
    
    public Pagereference closeticket(){ 
        TicketPopUp = true;
        AddTicketPopUp = false;
        return null;
    }
      
// ---------------------------------------------------------- Tickets method End ---------------------------------------------------------
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