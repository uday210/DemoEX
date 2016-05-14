global with sharing class BLN_Utill_BAL {

   // To  get mytickets with parsed data
	public Static List<BLN_ASC_Utillcls.OrderInfo> getMytickets(String eventId, String userId, DateTime lmDate) {
		BLN_Mytickets_BAL mytcBal = new BLN_Mytickets_BAL();
		LIST<BLN_Mytickets_BAL.inncls>  inlists = mytcBal.userTickets(userId, eventId, 'BLN_Mytickets', '');
		BLN_ASC_Utillcls utill = new BLN_ASC_Utillcls();
		List<BLN_ASC_Utillcls.OrderInfo> OrdersList = new List<BLN_ASC_Utillcls.OrderInfo>();
		for (BLN_Mytickets_BAL.inncls inc : inlists) {
			if (null != lmDate) {
				SET<id> ordIds = new SET<id>();
				for (ticket__c t : inc.ticketsInn) { // checking last modified date to send modified data
              
                    if (!ordIds.contains(t.Order__c) && (t.lastmodifieddate > lmDate || inc.orderInn.lastmodifieddate > lmDate || inc.orderInn.BLN_TKT_profile__r.lastmodifieddate > lmDate)) {
                    
						OrdersList.add(utill.parseInncls(inc));
						ordIds.add(inc.orderInn.id);
					}
				}
			} else {
				OrdersList.add(utill.parseInncls(inc));
			}
		}
		return OrdersList;
	}

	public Static List<Container> getEventschedule(String eventId, DateTime lmDate) {
		BLN_Seminars_DAO.isMobile =true;// This is check request is from portal or Mobile in dao class
		BLN_SeminarsCon semcon = new BLN_SeminarsCon();
		semcon.selectedeventid = EventID;
		semcon.gaterFields();
		semcon.onchangeAct();
		BLN_Event_DAO evdao = new BLN_Event_DAO();
		String timezone;
		if (!(null != lmDate))
			lmDate = datetime.valueOf('0000-00-00 00:00:00');

		List<BLN_Event__c> eve = evdao.getEventDetails(EventID);
		if (eve.size() > 0) {
			timezone = eve[0].Time_Zone__c;
		}
		List<Container> conlist = new List<Container>();
        LIST<Participant__c> patispentspeakerslist = [select id, BLN_TKT_profile__r.Blogger__c,BLN_TKT_profile__r.Blog_URL__c,BLN_TKT_profile__r.TKT_Job_Title__c,BLN_TKT_profile__r.User_Pic__c,BLN_TKT_profile__r.FaceBookId__c,BLN_TKT_profile__r.LinkedInId__c,BLN_TKT_profile__r.TwitterId__c,BLN_TKT_profile__r.Biography__c,BLN_TKT_profile__r.Company_Description__c,BLN_TKT_profile__r.Company_Logo__c,BLN_TKT_profile__r.Company_Website_URL__c,BLN_TKT_profile__c, BLN_TKT_profile__r.First_Name__c, BLN_TKT_profile__r.Last_Name__c , (select id, Name from BLN_Participant_Role__r) from Participant__c where Time_Slot__r.Agenda__r.Event__c = :EventID];
		MAP<ID, LIST<string>> rolemap = new MAP<ID, LIST<string>>();
		for (Participant__c p : patispentspeakerslist) {
			LIST<string> rlname = new LIST<string>();
			for (BLN_Participant_Role__c r : p.BLN_Participant_Role__r) {
				rlname.add(r.name);
			}
			rolemap.put(p.id, rlname);
		}
        system.debug('semcon.seminarInn.size()'+semcon.seminarInn.size());
       
		for (integer i = 0; i < semcon.seminarInn.size(); i++) {
         system.debug('semcon.seminarInn[i].agendaList.size()'+semcon.seminarInn[i].agendaList.size());
			for (integer j = 0; j < semcon.seminarInn[i].agendaList.size(); j++) {
				if (semcon.seminarInn[i].agendalist[j].lastmodifieddate > lmDate) {
				Container con = new Container();
				con.PaymentType = 'Free';
				con.TrackDescription = semcon.seminarInn[i].agendalist[j].Agenda_Description__c == null ? '' : semcon.seminarInn[i].agendalist[j].Agenda_Description__c;
					con.isDeleted =semcon.seminarInn[i].agendaList[j].isDeleted;
				con.mySchBool = false;
				for (Time_Slots__c tm : semcon.seminarInn[i].agendaList[j].Time_Slots__r) {
					con.AgendaID = semcon.seminarInn[i].agendaList[j].Id;
						con.Documents = new List<BLN_ASC_Utillcls.eventDocuments>();
                        system.debug('semcon.seminarInn[i].agendaList[j].Attachments=='+semcon.seminarInn[i].agendaList[j].Attachments);
                         for(Attachment attach :semcon.seminarInn[i].agendaList[j].Attachments){
                         	con.Documents.add(new BLN_ASC_Utillcls.eventDocuments(attach));
                         }
                        con.seminarType = semcon.seminarInn[i].agendaList[j].Visibility__c;
					con.displayOrder = semcon.seminarInn[i].agendaList[j].Agenda_Display_Order__c;
					con.ProgrammeName = semcon.seminarInn[i].agendaList[j].Agenda_Name__c;
					Datetime startdate = tm.Slot_Start_date__c;
					String stringstartdate = startdate.format('yyyy-MM-dd', 'GMT');
					con.ProgrammeDate = stringstartdate;
					String stringstarttime = startdate.format('hh:mm a', 'GMT');
					con.StartTime = stringstarttime;
					Datetime endtime = tm.Slot_End_date__c;
					String stringendtime = endtime.format('hh:mm a', 'GMT');
					con.EndTime = stringendtime;
					con.programStartDateTime = tm.Slot_Start_date__c;
					con.programEndDateTime = tm.Slot_End_date__c;
                    con.video=semcon.seminarInn[i].agendaList[j].Video__c;
				}
				con.tktprofiles = new List<tktprofile>();
				for (Participant__c pc : semcon.agendaParticipants.get(semcon.seminarInn[i].agendaList[j].id)) {
					tktprofile gn = new tktprofile();
					gn.tktprofileID = pc.BLN_TKT_profile__c;
					gn.ParticipantRole = rolemap.get(pc.id);
					con.tktprofiles.add(gn);
				}
				con.ROOMS = new List<ROOM>();
				for (Time_Slots__c tm : semcon.seminarInn[i].agendaList[j].Time_Slots__r) {
					if (tm.Room__r.NAME != null) {
						ROOM r = new ROOM();
						r.ROOMNAME = tm.Room__r.NAME;
						r.ROOMNUMBER = tm.Room__r.Room_Number__c;
						con.ROOMS.add(r);
					}
				}
				conlist.add(con);
			}
		}
		}
		return  conlist;
	}

	public Static List<container> getSeminars(String eventId, String userid, DateTime lmDate) {
		BLN_Seminars_DAO.isMobile =true; // This is check request is from portal or Mobile in dao class
		BLN_Seminars_updCon semconu = new BLN_Seminars_updCon();
		semconu.selectedeventid = EventID;
		semconu.urlCheck = 'BLN_agenda';
		semconu.groupByoption = 'Seminargrp';
		semconu.gaterFields();
		semconu.onchangeAct();
		if (!(null != lmDate))
			lmDate = datetime.valueOf('0000-00-00 00:00:00');

		BLN_Ticket_DAO btd = new BLN_Ticket_DAO();
		MAP<string, string> paymentMAp = new MAP<string, string>();
		LIST<ticket__C> ticlst = new LIST<ticket__C>();
		ticlst = btd.eventSeminarTickets(eventid);
		set<id> trackList = new set<id>();
		MAP<id,Ticket__c> maoIsWithRc = new MAP<id,Ticket__c>();
        LIst<item_pool__c> packageItems = new LIst<item_pool__c>();

        for(Item_Pool__c blnItm : [select id,Addon_Parent__c,(select id,Payment__c from Items__r) from item_pool__c where Event__c=:eventId and (item_type__r.Name='Seminars' OR item_type__r.Name='Package')]){
          if(blnItm.Items__r.size()>0){ 
           for(BLN_Item__c it : blnItm.Items__r ){
             paymentMAp.put(blnItm.id, it.Payment__c);
           }
          }else{
          	 packageItems.add(blnItm);
          }  
        }
        for(Item_Pool__c blnItmpckg :packageItems){ // Seminars in package line item
           paymentMAp.put(blnItmpckg.id, paymentMAp.get(blnItmpckg.Addon_Parent__c));
        }

		for (ticket__c t : ticlst) {
			System.debug('Ticket Id '+t.id+' t.item_pool__c '+t.item_pool__c); 
			if (t.tkt_profile__r.BLN_GN_User__r.User__c == Userid)
				trackList.add(t.item_pool__c);
			/*if (!paymentMAp.containskey(t.item_pool__c)) {
				paymentMAp.put(t.item_pool__c, t.item__r.Payment__c);
			}*/
			//maoIsWithRc.put(t.id,tc); 
		}
		System.debug('Payment MAp Values '+paymentMAp);
		List<Container> conlist1 = new List<Container>();
		for (integer i = 0; i < semconu.seminarInn.size(); i++) {
			for (integer j = 0; j < semconu.seminarInn[i].agendaList.size(); j++) {

				//if (semconu.seminarInn[i].agendalist[j].lastmodifieddate > lmDate) {
				    System.debug('Last Date '+semconu.seminarInn[i].agendalist[j].lastmodifieddate );
				     System.debug('Last Date 2222  '+lmDate);
				   
					// && paymentMAp.keySet().contains(semconu.seminarInn[i].agendaList[j].BLN_Ticket__c)
				Container con1 = new Container();
				if (null != paymentMAp) {
						//System.debug('semconu.seminarInn[i].agendaList[j] '+semconu.seminarInn[i].agendaList[j].BLN_Ticket__c);
					if (paymentMAp.containskey(semconu.seminarInn[i].agendaList[j].BLN_Ticket__c)) {
						con1.PaymentType = paymentMAp.get(semconu.seminarInn[i].agendaList[j].BLN_Ticket__c);
					}
				}
					con1.isDeleted =semconu.seminarInn[i].agendaList[j].isDeleted;
				con1.TrackName = semconu.seminarInn[i].agendaList[j].BLN_Track__r.Name;
				con1.TrackDescription = semconu.seminarInn[i].agendalist[j].Agenda_Description__c == null ? '' : semconu.seminarInn[i].agendalist[j].Agenda_Description__c;
				if (trackList.contains(semconu.seminarInn[i].agendaList[j].BLN_Ticket__c)) {
					con1.mySchBool = true;
				} else {
					con1.mySchBool = false;
				}
				for (Time_Slots__c tm : semconu.seminarInn[i].agendaList[j].Time_Slots__r) {
					con1.AgendaID = semconu.seminarInn[i].agendaList[j].Id;
						con1.Documents = new List<BLN_ASC_Utillcls.eventDocuments>();
                         for(Attachment attach :semconu.seminarInn[i].agendaList[j].Attachments){
                         	con1.Documents.add(new BLN_ASC_Utillcls.eventDocuments(attach));
                         }
                        con1.seminarType = semconu.seminarInn[i].agendaList[j].Visibility__c;
					con1.displayOrder = semconu.seminarInn[i].agendaList[j].Agenda_Display_Order__c;
					con1.ProgrammeName = semconu.seminarInn[i].agendaList[j].Agenda_Name__c;
					Datetime startdate = tm.Slot_Start_date__c;
					String stringstartdate = startdate.format('yyyy-MM-dd', 'GMT');
					con1.ProgrammeDate = stringstartdate;
					String stringstarttime = startdate.format('hh:mm a', 'GMT');
					con1.StartTime = stringstarttime;
					Datetime endtime = tm.Slot_End_date__c;
					String stringendtime = endtime.format('hh:mm a', 'GMT');
					con1.EndTime = stringendtime;
					con1.programStartDateTime = tm.Slot_Start_date__c;
					con1.programEndDateTime = tm.Slot_End_date__c;
                    con1.video=semconu.seminarInn[i].agendaList[j].Video__c;
				}
				con1.tktprofiles = new List<tktprofile>();
				for (Participant__c pc : semconu.agendaParticipants.get(semconu.seminarInn[i].agendaList[j].id)) {
					tktprofile gn = new tktprofile();
					gn.tktprofileID = pc.BLN_TKT_profile__c;
					list<string> role = new  list<string>();
					role.add(pc.BLN_Participant_Role__r.Name);
					gn.ParticipantRole = role;
					con1.tktprofiles.add(gn);
				}
				con1.ROOMS = new List<ROOM>();
				for (Time_Slots__c tm : semconu.seminarInn[i].agendaList[j].Time_Slots__r) {
					if (tm.Room__r.NAME != null) {
						ROOM r = new ROOM();
						r.ROOMNAME = tm.Room__r.NAME;
						r.ROOMNUMBER = tm.Room__r.Room_Number__c;
						con1.ROOMS.add(r);
					}
				}
				conlist1.add(con1);
				//}
			}
		}
		return conlist1;
	}

	Static BLN_Ticket_DAO tcdao = new BLN_Ticket_DAO();
	// To get booths belongs to Event
	public Static List<BLN_ASC_Utillcls.TicketInfo> getBooths(String eventId, DateTime lmDate) {
		//String wherecon = null != lmDate ? ' and Item__r.Item_Type__r.Name = \'Booths /Tables\'' + ' and lastmodifieddate >  :lmDate': ' and Item__r.Item_Type__r.Name = \'Booths /Tables\'';
		List<Ticket__c> boothTickets = new List<Ticket__c>();
        boothTickets = [Select (SELECT Ticket_id__r.Tkt_profile__r.Blogger__c,Ticket_id__r.Tkt_profile__r.Blog_URL__c,LastModifiedDate, Ticket_id__r.Name, Ticket_id__r.tkt_profile__r.TKT_Company__c, id, BLN_Room__c, BLN_Room__r.Name, BLN_Room__r.Room_Number__c, Booth_Area__c, Booth_Number__c, Booth_Size__c, Booth_Type__c, Kiosk_Description__c, Kiosk_Modules__c, Kiosk_Module_Type__c, Parameters__c,Visibility__c from booth_maps__r WHERE Visibility__c='Public'), Item_Pool__r.Item_Pool_Name__c, Item__r.item_name__c, Order_Item__r.Name, Order_Item__c, Item__r.Name, Item__c, Item_Type__r.Name, Parent_ID__c, Item_Pool__r.Badgable__c, Item_Pool__c, Item_Pool__r.Name, Ticket_Display_Order__c, Item_Pool__r.Item_Type__r.Name, LastModifiedDate, Badge_Label__c, Ticket_Status__c, id, Order__c , Name, Custom_Barcode__c, Note__c, Tag_No__c, Scan_Id__c, tkt_profile__r.First_Name__c, Tkt_profile__r.Last_Name__c, Tkt_profile__r.Email__c, Tkt_profile__r.TKT_Company__c, Tkt_profile__r.Mobile__c, Item__r.Item_Type__r.Name, TKT_profile__r.TKT_Job_Title__c, TKT_profile__r.User_Pic__c, TKT_profile__r.FaceBookId__c, TKT_profile__r.LinkedInId__c, TKT_profile__r.TwitterId__c, TKT_profile__r.Biography__c, TKT_profile__r.Company_Description__c, TKT_profile__r.Company_Logo__c, TKT_profile__r.Company_Website_URL__c,TKT_profile__r.Blogger__c,TKT_profile__r.Blog_URL__c,Badge_ID__c,TKT_profile__r.Video__c from Ticket__c where Event__c = : eventid and (Ticket_Status__c = 'Booked' OR Ticket_Status__c = 'Cancelled') and (Item__r.Item_Type__r.Name = 'Booths /Tables' OR Item_pool__r.Item_Type__r.Name = 'Booths /Tables') ];
		SET<id> tktIds =new SET<id>();
		for(Ticket__c tv:boothTickets){
           tktIds.add(tv.Tkt_profile__c);
	    }
        BLN_ASC_Utillcls.tktps =new MAP<id,Tkt_profile__c>([select id,(select id,Name,isDeleted from Attachments) from Tkt_profile__c where id In :tktIds]); 
		List<BLN_ASC_Utillcls.TicketInfo> boothsList = new List<BLN_ASC_Utillcls.TicketInfo>();
		for (Ticket__c tc : boothTickets) {
			if (null != lmDate) {
				if (tc.LastModifiedDate > lmDate) { // Checking updated date of ticket more than req date
					boothsList.add(new BLN_ASC_Utillcls.TicketInfo(tc));
				} else {
					for (Booth_Map__c bm : tc.booth_maps__r) { // Checking updated date of booth more than req date
						if (bm.LastModifiedDate > lmDate)
							boothsList.add(new BLN_ASC_Utillcls.TicketInfo(tc));
					}
				}
			} else {
              for(Booth_Map__c bm : tc.booth_maps__r){
				boothsList.add(new BLN_ASC_Utillcls.TicketInfo(tc));
			}
		}
		}
		return boothsList;
	}

	public Static  List<BLN_ASC_Utillcls.TicketInfo> getSpeakers(String eventId, DateTime lmDate) {
		String wherecon = null != lmDate ? ' and (Item__r.Item_Type__r.Name = \'Speaker\' OR  Item_Pool__r.Item_Type__r.Name = \'Speaker\')' + ' and lastmodifieddate >  :lmDate' : ' and Item__r.Item_Type__r.Name = \'Speaker\'';
		List<Ticket__c> speakerTickets = tcdao.getEddata(eventId, wherecon, lmDate);
		System.debug('Speaker Info ' + speakerTickets);
		List<BLN_ASC_Utillcls.TicketInfo> TicketInfoList = new List<BLN_ASC_Utillcls.TicketInfo>();
        SET<id> spktktIds =new SET<id>();
        for (Ticket__c tc : speakerTickets) {
         spktktIds.add(tc.Tkt_profile__c);
           
        }
        BLN_ASC_Utillcls.tktps =new MAP<id,Tkt_profile__c>([select id,(select id,isDeleted,Name from Attachments) from Tkt_profile__c where id In :spktktIds]); 
        
		for (Ticket__c tc : speakerTickets) {
			TicketInfoList.add(new BLN_ASC_Utillcls.TicketInfo(tc));
		}
		return TicketInfoList;
	}

	public Static List<BLN_ASC_Utillcls.TicketInfo> getSponsors(String eventId, DateTime lmDate) {
		BLN_Booth_Map_DAO bmapDAO1 = new BLN_Booth_Map_DAO();
		List<Ticket__c> sponsorTickets = new List<Ticket__c>();
        sponsorTickets = [Select TKT_profile__r.Blogger__c,TKT_profile__r.Blog_URL__c,(SELECT LastModifiedDate, Ticket_ID__c, id, Display_Order__c, Logo_Size__c, Sponsorship_Category__c,Visibility__c from BLN_Sponsorships__r where Visibility__c='Public'), Item_Pool__r.Item_Pool_Name__c, Item__r.item_name__c, Order_Item__r.Name, Order_Item__c, Item__r.Name, Item__c, Item_Type__r.Name, Parent_ID__c, Item_Pool__r.Badgable__c, Item_Pool__c, Item_Pool__r.Name, Ticket_Display_Order__c, Item_Pool__r.Item_Type__r.Name, LastModifiedDate, Badge_Label__c, Ticket_Status__c, id, Order__c , Name, Custom_Barcode__c, Note__c, Tag_No__c, Scan_Id__c, tkt_profile__r.First_Name__c, Tkt_profile__r.Last_Name__c, Tkt_profile__r.Email__c, Tkt_profile__r.TKT_Company__c, Tkt_profile__r.Mobile__c, Item__r.Item_Type__r.Name, TKT_profile__r.TKT_Job_Title__c, TKT_profile__r.User_Pic__c, TKT_profile__r.FaceBookId__c, TKT_profile__r.LinkedInId__c, TKT_profile__r.TwitterId__c, TKT_profile__r.Biography__c, TKT_profile__r.Company_Description__c, TKT_profile__r.Company_Logo__c, TKT_profile__r.Company_Website_URL__c,Badge_ID__c,TKT_profile__r.Video__c from Ticket__c where Event__c = : eventid and (Ticket_Status__c = 'Booked' OR Ticket_Status__c = 'Cancelled') and (Item__r.Item_Type__r.Name = 'Sponsorship' OR Item_Pool__r.Item_Type__r.Name = 'Sponsorship')];
       SET<id> tktIds =new SET<id>();
		for(Ticket__c tv:sponsorTickets){
           tktIds.add(tv.Tkt_profile__c);
	    }
        BLN_ASC_Utillcls.tktps =new MAP<id,Tkt_profile__c>([select id,(select id,isDeleted,Name from Attachments) from Tkt_profile__c where id In :tktIds]); 
		List<BLN_ASC_Utillcls.TicketInfo> TicketInfoList = new List<BLN_ASC_Utillcls.TicketInfo>();
		for (Ticket__c tc : sponsorTickets) {
			if (null != lmDate) {
				if (tc.LastModifiedDate > lmDate) {
					TicketInfoList.add(new BLN_ASC_Utillcls.TicketInfo(tc));
				} else {
					for (BLN_Sponsorships__c bm : tc.BLN_Sponsorships__r) { // Checking updated date of booth more than req date
						if (bm.LastModifiedDate > lmDate)
							TicketInfoList.add(new BLN_ASC_Utillcls.TicketInfo(tc));
					}
				}
			} else {
             for (BLN_Sponsorships__c bm : tc.BLN_Sponsorships__r) {
			TicketInfoList.add(new BLN_ASC_Utillcls.TicketInfo(tc));
		}
		}
		}
		return TicketInfoList;
	}

	global Static List<BLN_ASC_Utillcls.TicketInfo> getAttendees(String eventId, String lastattId, Integer lt, DateTime lmDate) {
		List<Ticket__c> attendees = new List<Ticket__c>();
		List<BLN_ASC_Utillcls.TicketInfo> TicketInfoList = new List<BLN_ASC_Utillcls.TicketInfo>();
		String wherecon = '';
		String whereCon2='';
		System.debug('PPPPPPPPP '+lastattId +' EEEEEEEE '+lmDate);
		if (lastattId != null && lastattId != '') {
			if (null != lmDate){
              //  wherecon = ' and (Item__r.Item_Type__r.Badgable__c = \'B - Badge\' OR  Item_Pool__r.Item_Type__r.Badgable__c = \'B - Badge\') AND id <= \'' + lastattId + '\' and lastmodifieddate > :lmDate  Order By id limit ' + lt;
               // whereCon2 =' and (Item__r.Item_Type__r.Badgable__c = \'B - Badge\' OR  Item_Pool__r.Item_Type__r.Badgable__c = \'B - Badge\') AND id > \'' + lastattId + '\' Order By id';
              
              wherecon = ' and (Item_Pool__r.Badgable__c = \'B - Badge\' OR  Item__r.Item_Pool__r.Badgable__c = \'B - Badge\') AND id <= \'' + lastattId + '\' and (lastmodifieddate > :lmDate OR Item_Pool__r.lastmodifieddate > :lmDate) Order By id limit ' + lt;
              whereCon2 =' and (Item_Pool__r.Badgable__c = \'B - Badge\' OR  Item__r.Item_Pool__r.Badgable__c = \'B - Badge\') AND id > \'' + lastattId + '\' Order By id';
              
			 }
			else{
               // wherecon = ' and (Item__r.Item_Type__r.Badgable__c = \'B - Badge\' OR  Item_Pool__r.Item_Type__r.Badgable__c = \'B - Badge\') AND id > \'' + lastattId + '\' Order By id limit ' + lt;
              wherecon = ' and (Item_Pool__r.Badgable__c = \'B - Badge\' OR  Item__r.Item_Pool__r.Badgable__c = \'B - Badge\') AND id > \'' + lastattId + '\' Order By id limit ' + lt;
			}
		} else {
          //  wherecon = ' and (Item__r.Item_Type__r.Badgable__c = \'B - Badge\' OR  Item_Pool__r.Item_Type__r.Badgable__c = \'B - Badge\')' + 'Order By id limit ' + lt;
           wherecon = ' and (Item_Pool__r.Badgable__c = \'B - Badge\' OR  Item__r.Item_Pool__r.Badgable__c = \'B - Badge\')' + 'Order By id limit ' + lt;
		}
		attendees = tcdao.getEddata(eventId, wherecon, lmDate);
		 if(attendees.size()<20 && (whereCon2!='' && whereCon2!='')){ // If modified records are less than 20 i am sending next load more records
		 	BLN_PromoCode_BAL promo =new BLN_PromoCode_BAL();
		 	BLN_Event__c se =promo.eventdetails(eventid);
		 	integer limitval =0;
			 if(se.scan_attendee_limit__c!=null){
			   limitval =integer.valueOf(se.scan_attendee_limit__c);
			  } 
		 	whereCon2+=' limit '+limitval;
		 	//System.debug('BBBBBBB   '+wherecon);
		    attendees.addAll(tcdao.getEddata(eventId, wherecon2,null));
		  }
        System.debug('NNNNNNNNNN  '+attendees.size());


		for (Ticket__c tc : attendees) {
			TicketInfoList.add(new BLN_ASC_Utillcls.TicketInfo(tc));
		}
		return TicketInfoList;
	}

   global Static List<BLN_ASC_Utillcls.eventDocuments> getDocs(String eventId,DateTime lmDate) {
	List<BLN_ASC_Utillcls.eventDocuments> docsList = new List<BLN_ASC_Utillcls.eventDocuments>();
	 BLN_EventDocuments_Dao Ed = new BLN_EventDocuments_Dao();
	  List<BLN_Event_Document__c> docs = new List<BLN_Event_Document__c>();
	  System.debug('BLN_Event_Document__c Value'+Ed.getDocs(eventId)); 
       for(BLN_Event_Document__c edSin :Ed.getDocs(eventId)){
          if(null!=lmDate){
            if(edSin.lastmodifiedDate>lmDate){
                docsList.add(new BLN_ASC_Utillcls.eventDocuments(edSin));
             }else{
                for(Attachment att :edSin.Attachments){
                   if(att.LastModifiedDate>lmDate)
                     docsList.add(new BLN_ASC_Utillcls.eventDocuments(edSin));
                }
             } 
          }else{
               docsList.add(new BLN_ASC_Utillcls.eventDocuments(edSin));
             } 
          }  
        return docsList;	
   }

   //---------------
    
   global Static List<BLN_ASC_Utillcls.nonBadgeItempool> getNonBadgeitempool(String eventId, DateTime lmDate) {
        list<Item_Pool__c> itempoolfornonBadge = new list<Item_Pool__c>();
        BLN_ItemPool_DAO itepoldao = new BLN_ItemPool_DAO();
        List<BLN_ASC_Utillcls.nonBadgeItempool> nonBadgetmpids= new List<BLN_ASC_Utillcls.nonBadgeItempool>();
        String wherecon = '';
       
        
            if (null != lmDate){
               
        
        itempoolfornonBadge = itepoldao.getitempoollist(eventId,lmDate);
        

        for (Item_Pool__c tc : itempoolfornonBadge) {
            nonBadgetmpids.add(new BLN_ASC_Utillcls.nonBadgeItempool(tc));
        }
        }
       
        return nonBadgetmpids;
    }
   //=========

//For seminar
	global class container {
		public String AgendaID {get; set;}
		public String ProgrammeName {get; set;}
		public String ProgrammeDate {get; set;}
		public String StartTime {get; set;}
		public String EndTime {get; set;}
		public List<ROOM> ROOMS {get; set;}
		public List<tktprofile> tktprofiles {get; set;}
		public String TrackDescription {get; set;}
		public String TrackName {get; set;}
		public decimal displayOrder {get; set;}
		public datetime programStartDateTime {get; set;}
		public datetime programEndDateTime {get; set;}
		public boolean mySchBool {get; set;}
		public string PaymentType {get; set;}
		public List<BLN_ASC_Utillcls.eventDocuments> Documents{get;set;}
		public String seminarType{get;set;}
		public Boolean isDeleted{get;set;}
        public string video{get;set;}
		public container () {}
	}

	global class ROOM {
		public String ROOMNAME {get; set;}
		public String ROOMNUMBER {get; set;}
	}
	global class tktprofile {
		public String tktprofileID {get; set;}
		public LIST<String> ParticipantRole {get; set;}
	}
}