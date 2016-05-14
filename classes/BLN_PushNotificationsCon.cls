global class BLN_PushNotificationsCon {

public BLN_UtillDisplayLinks myticket{get;set;}
    
    public string selectedEventId{get;set;}
    public BLN_UtillDisplayLinks pushNotif{get;set;}
    public BLN_Event__c se{get;set;}
    public List<Reg_Setting__c> regsetting{get;set;}
    public Map<String,Integer> regsettingmap{get;set;}
    public String itype{get;set;}
    public List<Ticket__c> Ticketlist{get;set;}
    public List<EmailCampaign__c> EmailCampaignLst{get;set;}
    public date currentDate{get;set;}
    public dateTime currentDateTime{get;set;}
    public string currDtTm{get;set;}
    public datetime eveEndTime{get;set;}
    public string eveEdTime{get;set;}
    
    public BLN_PushNotificationsCon(){
         
        cookie k = ApexPages.currentPage().getcookies().get('counter');
        if(k!=null){
        selectedEventId =k.getValue();
        }
        
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
        se = new BLN_Event__c();
        try{
        se = blneventdetailbal.eventdetails(selectedEventId );
        }catch(exception e){}
        
        BLN_EmailCampaign_DAO ecDAO=new BLN_EmailCampaign_DAO();
        EmailCampaignLst = new List<EmailCampaign__c>();
        EmailCampaignLst = ecDAO.getEmailCampaigns(selectedEventId,'Notifications');
        
        BLN_Reg_Settings_DAO regDAO=new BLN_Reg_Settings_DAO();
        regsetting = new List<Reg_Setting__c>();
        regsetting = regDAO.getItemtypeRegSetList(selectedEventId);

        BLN_PushNotificationsCon_BAL pnBAL=new BLN_PushNotificationsCon_BAL();
        regsettingmap = pnBAL.getregsett(selectedEventId);
        
        BLN_timeConToEvzoneCon timezonecl=new BLN_timeConToEvzoneCon();     
        currDtTm = system.now().format('MM/dd/yyyy hh:mm a',se.time_zone__c);             
        currentDateTime = timezonecl.getDateBasedOnEventTimeZone(currDtTm,selectedEventId);
        currentDate = date.newinstance(currentDateTime.year(), currentDateTime.month(), currentDateTime.day());
        
        BLN_timeConToEvzoneCon timezonecl1=new BLN_timeConToEvzoneCon();
        eveEdTime = se.End_Date__c.format('MM/dd/yyyy hh:mm a',se.time_zone__c);
        datetime eveEndDtTime = timezonecl1.getDateBasedOnEventTimeZone(eveEdTime,selectedEventId);
        system.debug('eveEndDtTime '+eveEndDtTime );
        
    }
    
    public PageReference sendnotification() {
        string pnName = ApexPages.currentPage().getParameters().get('pnName');
        string pnMsg = ApexPages.currentPage().getParameters().get('pnMsg');
        string ActStatus = ApexPages.currentPage().getParameters().get('ActStatus');
        string SentStatus = ApexPages.currentPage().getParameters().get('SentStatus');
        string sendDate = ApexPages.currentPage().getParameters().get('sendDate');
        system.debug('sendDate'+sendDate);
        if(sendDate != '' && sendDate != null){
            BLN_timeConToEvzoneCon timezonecl=new BLN_timeConToEvzoneCon();                
            ScheduleTime  = timezonecl.getDateBasedOnEventTimeZone(sendDate,selectedeventid);
        }

        List<String> parts = itype.split(',');
        String idInClause = '(\'';

        for(integer i=0;i<parts.size();i++)
        {
            if(parts[i]=='Attendee')
                parts[i]='Admissions';
            idInClause += parts[i]+ '\',\'';
        }
        idInClause  = idInClause.substring(0,idInClause.length()-2);
        idInClause += ')';

        //GET ALL THE USER AND COMPANY INFORMATION FROM BOOKED TICKET BASED ON POOLID or TICKETID
        String q='select id,name,Item_Type__c,Item_Pool__r.Item_Type__r.name,Item__r.Item_Type__r.name,Item_Type__r.name,Item_Pool__c,tkt_profile__c,Tkt_profile__r.BLN_Company__c,Ticket_Status__c,Tkt_profile__r.Home_Phone__c,Tkt_profile__r.First_Name__c,Tkt_profile__r.Last_Name__c,Tkt_profile__r.Email__c,Tkt_profile__r.User_Pic__c,Tkt_profile__r.BLN_GN_User__r.User__c,Tkt_profile__r.FaceBookId__c,Tkt_profile__r.LinkedInId__c,Tkt_profile__r.BLN_Company__r.Company_Logo__c,Tkt_profile__r.BLN_Company__r.Name,Tkt_profile__r.BLN_Company__r.Website_URL__c from Ticket__c where (Item__r.Item_Type__r.Name in'+idInClause+' or Item_Pool__r.Item_Type__r.name in'+idInClause+') and Event__c=\''+selectedEventId+'\' and (Ticket_Status__c=\'Booked\' or Ticket_Status__c=\'Checked-in\' or Ticket_Status__c=\'Checked-out\') and order__r.Order_Status__c !=\'Cancelled\' and order__r.Order_Status__c !=\'Abandoned\' and order__r.Order_Status__c !=\'Not Paid\'';
        
        Ticketlist = new List<Ticket__c>();
        Ticketlist= Database.query(q);
       
        Set<String> users = new Set<String>();
        for(ticket__c tic:Ticketlist){
            users.add(tic.tkt_profile__r.BLN_GN_User__r.User__c);
        }
       
        EmailCampaign__c ec=new EmailCampaign__c();
        ec.Feature_Type__c = 'Notifications';
        ec.Event__c = selectedEventId;
        ec.Template_Status__c = ActStatus;
        if(ActStatus == 'Active'){
        ec.Email_Status__c = SentStatus;
        }else{
        ec.Email_Status__c = '';
        }
        ec.CampSubject__c = pnMsg;
        ec.Name = pnName;
        ec.ToList__c = itype;

        if(SentStatus=='Sent' && ActStatus == 'Active'){
            BLN_timeConToEvzoneCon timezonecl=new BLN_timeConToEvzoneCon();     
            string sendDt = system.now().format('MM/dd/yyyy hh:mm a',se.time_zone__c);             
            ec.Email_Send_Date__c = timezonecl.getDateBasedOnEventTimeZone(sendDt,selectedeventid);
        }else if(SentStatus!='Sent' && ActStatus == 'Active'){           
            ec.Email_Send_Date__c = ScheduleTime ;
        }
        
        insert ec;
        
        if(SentStatus=='Sent' && ActStatus == 'Active'){
        notificationMethod(users,pnMsg,ec.id,ec.Name);
        }else if(SentStatus!='Sent' && ActStatus == 'Active'){
        scheduleMethod(users,pnMsg,ec.id,ec.Name);
        }

        Pagereference pg=new pagereference('/apex/BLN_PushNotifications');
        pg.setredirect(true);
        return pg;
    }

    public void notificationMethod(set<string> users,string pnMsg,id ecId,string ecName){
        
        BLN_AppMenuItem_DAO ConnectedAppsDAO = new BLN_AppMenuItem_DAO();
        LIST<AppMenuItem> connectedApps=new LIST<AppMenuItem>();
        ConnectedApps = ConnectedAppsDAO.getConnectedAppDetails();
        
        for(AppMenuItem conApp:ConnectedApps){
            if(conApp.MobilePlatform == 'android'){
                Messaging.PushNotification msg =new Messaging.PushNotification();
                Map<String, Object> androidPayload = new Map<String, Object>();
                androidPayload.put('message',pnMsg);
                androidPayload.put('content-available', 1);
                androidPayload.put('Key', 'Attendee_Request');
                msg.setPayload(androidPayload);
                msg.send(conApp.Label, users);
            }else if(conApp.MobilePlatform == 'ios'){    

                Messaging.PushNotification iphoneMsg =new Messaging.PushNotification();
                    Map<String, Object> iphonePayload = new Map<String, Object>();
                    iphonePayload.put('alert',pnMsg);
                    iphonePayload.put('sound','calling.mp3');
                    iphonePayload.put('content-available',1);
                    iphonePayload.put('badge',1);
                    
                    Map<String, Object> iphonePayload2 = new Map<String, Object>();
                    iphonePayload2.put('aps',iphonePayload);
                    iphonePayload2.put('message',pnMsg);
                    iphonePayload2.put('Key', 'FROM PORTAL');
                    iphonePayload2.put('NotificationId',ecId);
                    iphonePayload2.put('TicketID',ecId);
                    iphonePayload2.put('title',ecName);
                    
                    iphoneMsg.setPayload(iphonePayload2);
                    iphoneMsg.send(conApp.Label, users);
            }
        }

    }
    
    public dateTime ScheduleTime{get;set;}
    public string message{get;set;}
    public string title{get;set;}
    public Id SchedulerId{get;set;}
    
    public void scheduleMethod(set<string> users,string pnMsg,id campId,string ecName){
         datetime nextScheduleTime = ScheduleTime;
         String day = string.valueOf(nextScheduleTime.day());
         String month = string.valueOf(nextScheduleTime.month());
         String hour = string.valueOf(nextScheduleTime.hour());
         String minute = string.valueOf(nextScheduleTime.minute());
         String second = string.valueOf(nextScheduleTime.second());
         String year = string.valueOf(nextScheduleTime.year());
         String strJobName = 'Reserve Job-' + campId+ '-' + minute + '_' + hour + '_' + day + '_' + month + '_' + year;
         String strSchedule = '0 ' + minute + ' ' + hour + ' ' + day + ' ' + month + ' ?' + ' ' + year;
         SchedulerId = System.schedule(strJobName, strSchedule,new BLN_PushNotificationSc(users,pnMsg,campId,ecName)); 
         
         EmailCampaign__c ecSch= new EmailCampaign__c();
         BLN_EmailCampaign_DAO ecDAO=new BLN_EmailCampaign_DAO();
         ecSch = ecDAO.getECforID(campId);
         ecSch.Schedule_Id__c = SchedulerId;
         update ecSch;
    }


     @RemoteAction 
    global static viewClass viewDetails(string currentID,string tzone){
       EmailCampaign__c ViewRecord= new EmailCampaign__c();
        if(currentID != null && currentID != ''){
            BLN_EmailCampaign_DAO ecDAO=new BLN_EmailCampaign_DAO();
            ViewRecord = ecDAO.getECforID(currentID);
            system.debug('Email_Send_Date__c'+ViewRecord.Email_Send_Date__c);
        }
        system.debug('ViewRecord'+ViewRecord);
        viewClass viewcls=new viewClass();
        viewcls.ViewRecord = ViewRecord;
        if(ViewRecord.Email_Send_Date__c != null){
            BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
            tz.tZone=tzone;
            tz.format='MM/dd/yyyy hh:mm a';
            tz.dateTimeValue=ViewRecord.Email_Send_Date__c; 
        viewcls.SendDate = tz.getTimeZoneValue();
        }else{
            viewcls.SendDate = null;
        }
        return viewcls;
    }
    
    global class viewClass{
        public EmailCampaign__c ViewRecord{get;set;}
        public String SendDate{get;set;}
    }
    
    @RemoteAction
    global static EmailCampaign__c saveEditNotif(string editID,string pnName,string pnMsg,string tolist,string ActStatus,string SentStatus,string sendDate,string selectedEventId,string tz){
        EmailCampaign__c editRecord= new EmailCampaign__c();
        BLN_EmailCampaign_DAO ecDAO=new BLN_EmailCampaign_DAO();
        editRecord = ecDAO.getECforID(editID);
        
        if(editRecord.Email_Status__c == 'Scheduled'){
            System.abortJob(editRecord.Schedule_Id__c);
        }
        
        List<String> parts = tolist.split(',');
        String idInClause = '(\'';

        for(integer i=0;i<parts.size();i++)
        {
            if(parts[i]=='Attendee')
                parts[i]='Admissions';
            idInClause += parts[i]+ '\',\'';
        }
        idInClause  = idInClause.substring(0,idInClause.length()-2);
        idInClause += ')';

        //GET ALL THE USER AND COMPANY INFORMATION FROM BOOKED TICKET BASED ON POOLID or TICKETID
        String q='select id,name,Item_Type__c,Item_Pool__r.Item_Type__r.name,Item__r.Item_Type__r.name,Item_Type__r.name,Item_Pool__c,tkt_profile__c,Tkt_profile__r.BLN_Company__c,Ticket_Status__c,Tkt_profile__r.Home_Phone__c,Tkt_profile__r.First_Name__c,Tkt_profile__r.Last_Name__c,Tkt_profile__r.Email__c,Tkt_profile__r.User_Pic__c,Tkt_profile__r.BLN_GN_User__r.User__c,Tkt_profile__r.FaceBookId__c,Tkt_profile__r.LinkedInId__c,Tkt_profile__r.BLN_Company__r.Company_Logo__c,Tkt_profile__r.BLN_Company__r.Name,Tkt_profile__r.BLN_Company__r.Website_URL__c from Ticket__c where (Item__r.Item_Type__r.Name in'+idInClause+' or Item_Pool__r.Item_Type__r.name in'+idInClause+') and Event__c=\''+selectedEventId+'\' and (Ticket_Status__c=\'Booked\' or Ticket_Status__c=\'Checked-in\' or Ticket_Status__c=\'Checked-out\') and order__r.Order_Status__c !=\'Cancelled\' and order__r.Order_Status__c !=\'Abandoned\' and order__r.Order_Status__c !=\'Not Paid\'';

        List<Ticket__c> Ticketlist = new List<Ticket__c>();
        Ticketlist= Database.query(q);
       
        Set<String> users = new Set<String>();
        for(ticket__c tic:Ticketlist){
            users.add(tic.tkt_profile__r.BLN_GN_User__r.User__c);
        }

        editRecord.Template_Status__c = ActStatus;
        if(ActStatus == 'Active'){
        editRecord.Email_Status__c = SentStatus;
        }else{
        editRecord.Email_Status__c = '';
        }
        editRecord.CampSubject__c = pnMsg;
        editRecord.Name = pnName;
        editRecord.ToList__c = tolist;

        BLN_timeConToEvzoneCon timezonecl=new BLN_timeConToEvzoneCon();
        if(SentStatus=='Sent' && ActStatus == 'Active'){
            string sendDt = system.now().format('MM/dd/yyyy hh:mm a',tz);             
            editRecord.Email_Send_Date__c = timezonecl.getDateBasedOnEventTimeZone(sendDt,selectedEventId);
        }else if(SentStatus!='Sent' && ActStatus == 'Active'){      
            editRecord.Email_Send_Date__c = timezonecl.getDateBasedOnEventTimeZone(sendDate,selectedEventId);
        }else if(ActStatus == 'Inactive'){
            editRecord.Email_Send_Date__c = null;
        }
        
        
        if(SentStatus=='Sent' && ActStatus == 'Active'){
            BLN_AppMenuItem_DAO ConnectedAppsDAO = new BLN_AppMenuItem_DAO();
            LIST<AppMenuItem> connectedApps=new LIST<AppMenuItem>();
            ConnectedApps = ConnectedAppsDAO.getConnectedAppDetails();
            
            for(AppMenuItem conApp:ConnectedApps){
                if(conApp.MobilePlatform == 'android'){
                    Messaging.PushNotification msg =new Messaging.PushNotification();
                    Map<String, Object> androidPayload = new Map<String, Object>();
                    androidPayload.put('message',pnMsg);
                    androidPayload.put('content-available', 1);
                    androidPayload.put('Key', 'Attendee_Request');
                    msg.setPayload(androidPayload);
                    msg.send(conApp.Label, users);
                }else if(conApp.MobilePlatform == 'ios'){    
                    Messaging.PushNotification iphoneMsg =new Messaging.PushNotification();
                    
                    Map<String, Object> iphonePayload = new Map<String, Object>();
                    iphonePayload.put('alert',pnMsg);
                    iphonePayload.put('sound','calling.mp3');
                    iphonePayload.put('content-available',1);
                    iphonePayload.put('badge',1);
                    
                    Map<String, Object> iphonePayload2 = new Map<String, Object>();
                    iphonePayload2.put('aps',iphonePayload);
                    iphonePayload2.put('message',pnMsg);
                    iphonePayload2.put('Key', 'FROM PORTAL');
                    iphonePayload2.put('NotificationId',editRecord.id);
                    
                    iphoneMsg.setPayload(iphonePayload2);
                    iphoneMsg.send(conApp.Label, users);
                }
            }
        }else if(SentStatus!='Sent' && ActStatus == 'Active'){
            datetime nextScheduleTime = editRecord.Email_Send_Date__c;//datetime.parse(sendDate);
             String day = string.valueOf(nextScheduleTime.day());
             String month = string.valueOf(nextScheduleTime.month());
             String hour = string.valueOf(nextScheduleTime.hour());
             String minute = string.valueOf(nextScheduleTime.minute());
             String second = string.valueOf(nextScheduleTime.second());
             String year = string.valueOf(nextScheduleTime.year());
             String strJobName = 'Reserve Job-' + editRecord.id+ '_' + minute + '_' + hour + '_' + day + '_' + month + '_' + year;
             String strSchedule = '0 ' + minute + ' ' + hour + ' ' + day + ' ' + month + ' ?' + ' ' + year;
             Id SchedulerId = System.schedule(strJobName, strSchedule,new BLN_PushNotificationSc(users,pnMsg,editRecord.Id,editRecord.Name)); 
             editRecord.Schedule_Id__c = SchedulerId;
        }
        system.debug('editRecord.Schedule_Id__c'+editRecord.Schedule_Id__c);
        update editRecord;
        return editRecord;
    }
    
    public pagereference delnotification(){
        string delEcId = ApexPages.currentPage().getParameters().get('delEcId');
        BLN_EmailCampaign_DAO ecDAO=new BLN_EmailCampaign_DAO();
        EmailCampaign__c EmailCampaign = new EmailCampaign__c();
        EmailCampaign = ecDAO.getECforID(delEcId);
        EmailCampaign.Email_Status__c='Deleted';
        update EmailCampaign;
        
        Pagereference pg=new pagereference('/apex/BLN_PushNotifications');
        pg.setredirect(true);
        return pg;
    }
    
    public pagereference cloneNotification(){
        string cloneEcId = ApexPages.currentPage().getParameters().get('cloneEcId');
        BLN_EmailCampaign_DAO ecDAO=new BLN_EmailCampaign_DAO();
        EmailCampaign__c EmailCampaign = new EmailCampaign__c();
        EmailCampaign = ecDAO.getECforID(cloneEcId);
        
        EmailCampaign__c EmailCampaignNew = new EmailCampaign__c();
        EmailCampaignNew.Template_Status__c = 'Inactive';
        EmailCampaignNew.Email_Send_Date__c=null;
        EmailCampaignNew.Email_Status__c='';
        EmailCampaignNew.Name=EmailCampaign.Name;
        EmailCampaignNew.Event__c = EmailCampaign.Event__c;
        EmailCampaignNew.CampSubject__c = EmailCampaign.CampSubject__c;
        EmailCampaignNew.ToList__c = EmailCampaign.ToList__c;
        EmailCampaignNew.Feature_Type__c = EmailCampaign.Feature_Type__c;
        
        insert EmailCampaignNew;
        
        Pagereference pg=new pagereference('/apex/BLN_PushNotifications');
        pg.setredirect(true);
        return pg;
    }
    
    public void displayPermissions() {
        cookie k = ApexPages.currentPage().getcookies().get('counter');
        if(k!=null){
        selectedEventId =k.getValue();
        }

        pushNotif = new BLN_UtillDisplayLinks();    
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
        se = new BLN_Event__c();
        try{
        se = blneventdetailbal.eventdetails(selectedEventId );
        pushNotif.EventName=se.Name;
        }catch(exception e){}

         pushNotif.ispushnotificationPage='active';
         pushNotif.tablabel='Push Notifications';
         pushNotif.isEventAdmin =true;
         pushNotif.EventId = selectedEventId ;
         pushNotif.isregistrationPageExpand='expand';
         pushNotif.userPermissions(userInfo.getUserId(),selectedEventId);
    }

}