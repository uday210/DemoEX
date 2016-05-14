@RestResource(urlMapping = '/BLN_ASC_Edexinfo/*')
global class BLN_ASC_Edexinfo {
	@HttpPost
	global static TotalList doPost() {
		RestRequest req = RestContext.request;
		String eventid = req.params.get('Event_id');
		String Userid = req.params.get('User_id');
		String requestedDate = req.params.get('LastModifiedDate');
		String lastAttId = req.params.get('lastattid'); 
        DateTime lmDate;
        String siteurl1 = Label.ImageUrl;
		String orgid = UserInfo.getOrganizationId();
		BLN_Reg_Settings_DAO regDAO = new BLN_Reg_Settings_DAO();
		TotalList TotalEdList = new TotalList();
    	if(requestedDate != '' && requestedDate != null)
	      lmDate  = dateTime.valueofGmt(requestedDate);
          System.debug('PPPPPPP '+lmDate);
          bln_app_settings_BAL bal=new bln_app_settings_BAL();
          bal.checkticdetails(eventid);
     
            for (Reg_Setting__c mobSett : regDAO.getMobileSettings(eventid,lmDate)) {
                 BLN_ASC_Utillcls.appSttings  sett = new BLN_ASC_Utillcls.appSttings(mobSett);
                 TotalEdList.appSettings.add(sett );

                                        }
          for (Reg_Setting__c mobSett : regDAO.getMobileSettings(eventid)) {
           
          BLN_ASC_Utillcls.appSttings  sett = new BLN_ASC_Utillcls.appSttings(mobSett);
             if (sett.ColumnName == 'Sponsors' && mobSett.Included__c ){
             sett.Include = bal.Sponsorsflag;
             } else if (sett.ColumnName == 'Seminars' && mobSett.Included__c ){
             sett.Include = bal.Seminarsflag;
             } else if (sett.ColumnName == 'Exhibitors' && mobSett.Included__c ){
             sett.Include = bal.Exhibitorflag;
             }else if (sett.ColumnName == 'Speakers' && mobSett.Included__c ){
             sett.Include = bal.Speakersflag;
             }
                if (mobSett.Defaullt_Label__c == 'My Tickets' )
                TotalEdList.OrdersList = BLN_Utill_BAL.getMytickets(eventid, Userid,lmDate); // Mytickets information
            if (mobSett.Defaullt_Label__c == 'Event Schedule')
                TotalEdList.Eventschedule = BLN_Utill_BAL.getEventschedule(eventid,lmDate); // Get Event schedule
            if (mobSett.Defaullt_Label__c == 'Exhibitors')
                TotalEdList.Booths = BLN_Utill_BAL.getBooths(eventid,lmDate);  // Getting booths
            if (mobSett.Defaullt_Label__c == 'Sponsors' )
                TotalEdList.Sponsers = BLN_Utill_BAL.getSponsors(eventid,lmDate); // Getting Sponsors
            if (mobSett.Defaullt_Label__c == 'Seminars')
                TotalEdList.Seminars = BLN_Utill_BAL.getSeminars(eventid, Userid,lmDate); // Get Seminars
            if (mobSett.Defaullt_Label__c == 'Speakers') // get Speakers
                TotalEdList.Speakers = BLN_Utill_BAL.getSpeakers(eventid,lmDate);
            if (mobSett.Defaullt_Label__c == 'Attendees') // Get Attendee
                TotalEdList.Attendees = BLN_Utill_BAL.getAttendees(eventid, lastAttId , 10,lmDate);
            if(lmDate!= null ){
            TotalEdList.nonBadgeItempool = BLN_Utill_BAL.getNonBadgeitempool(eventid,lmDate);
             }
            if(mobSett.Defaullt_Label__c == 'Event Documents')
		      TotalEdList.EventDocs	=BLN_Utill_BAL.getDocs(eventid,lmDate);	
		}
         BLN_ASC_MobileAppSettings bma = new BLN_ASC_MobileAppSettings();
         TotalEdList.Siteurl = siteurl1+'?oid='+orgid+'&id=';
         TotalEdList.LastModifiedDate =system.now().format('YYYY-MM-dd HH:mm:ss','GMT');
         return TotalEdList;
	}

	global class TotalList {
		public List<BLN_ASC_Utillcls.OrderInfo> OrdersList {get; set;}
		public List<BLN_ASC_Utillcls.TicketInfo> Booths {get; set;}
		public List<BLN_ASC_Utillcls.TicketInfo> Sponsers {get; set;}
		public List<BLN_ASC_Utillcls.TicketInfo> Speakers {get; set;}
		public List<BLN_ASC_Utillcls.TicketInfo> Attendees {get; set;}
		public List<BLN_Utill_BAL.Container> Eventschedule {get; set;}
		public List<BLN_Utill_BAL.Container> Seminars {get; set;}
		public List<BLN_ASC_Utillcls.appSttings> AppSettings{get;set;}
		public List<BLN_ASC_Utillcls.eventDocuments> EventDocs{get;set;}
        public List<BLN_ASC_Utillcls.nonBadgeItempool> nonBadgeItempool{get;set;}
		public String Siteurl{get;set;}
		public String LastModifiedDate{get;set;}
		public TotalList() {
			OrdersList = new List<BLN_ASC_Utillcls.OrderInfo>();
			Booths = new List<BLN_ASC_Utillcls.TicketInfo>();
			Sponsers = new List<BLN_ASC_Utillcls.TicketInfo>();
			Speakers = new List<BLN_ASC_Utillcls.TicketInfo>();
			Attendees = new List<BLN_ASC_Utillcls.TicketInfo>();
			Eventschedule = new List<BLN_Utill_BAL.Container>();
			Seminars = new List<BLN_Utill_BAL.Container>();
            AppSettings = new List<BLN_ASC_Utillcls.appSttings>();
            EventDocs = new List<BLN_ASC_Utillcls.eventDocuments>();
            nonBadgeItempool= new List<BLN_ASC_Utillcls.nonBadgeItempool>();
		}
	}
}