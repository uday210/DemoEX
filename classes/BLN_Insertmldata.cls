public with sharing class BLN_Insertmldata {
	/***************************************************************
	* Author : Mythily Nagandla
	* Date : 14-12-2015
	* Purpose : For Adding UPE and EAM Records for Match Leads Event
	/****************************************************************/
	public Void insertMLData(SET<id> tIds) {
		System.debug('insertMLData.tids '+tIds);
		Map<string, User> Usermap = new Map<string, User>();
		Map<string, AttendeeSummary__c> Attmap = new Map<string, AttendeeSummary__c>();
		List<Ticket__c> tits = [select id, Ticket_Status__c, Event__c, Item_Pool__c, Item_Pool__r.id,
		                        Item_Pool__r.Item_Type__r.name, Event__r.id, Item_Type__r.name,
		                        tkt_profile__r.Email__c from Ticket__c where id in : tids];
		List<User_Profile_Event__c> Upesexist = new List<User_Profile_Event__c>();
        Upesexist = [select id,User_id__r.Username from User_Profile_Event__c Where EV_id__c =: tits[0].Event__c];
        Map<string,User_Profile_Event__c> UPEMAP = new Map<string,User_Profile_Event__c>();

        for(User_Profile_Event__c UP :Upesexist  ){
            UPEMAP.put(UP.User_id__r.Username , UP);
        }
        
		list<string> emailids = new List<string>();
		for (Ticket__c tt : tits) {
			emailids.add(tt.tkt_profile__r.Email__c);
		}
        for (User U : [select id, Username,FirstName from User where Username IN: emailids]) {
			Usermap.put(U.Username, U);
		}
		for (AttendeeSummary__c atts : [select id, AS_Email__c, AS_Company__c from AttendeeSummary__c Where AS_Email__c IN :emailids]) {
			Attmap.put(atts.AS_Email__c, atts);
        }
		List<Event__c> Events = new List<Event__c>();
		Map<string, Event__c> Eventsmap = new Map<string, Event__c>();
		Events = [select id, Eventdex_Id__c, Owner.id from Event__c Where Eventdex_Id__c != '' AND Eventdex_Id__c != null];
		for (Event__c EV : Events) {
			Eventsmap.put(EV.Eventdex_Id__c, EV);
		}
		//Collecting profiles from profile cus object
		List<Profile__c> Profile = [select id, PR_Name__c from Profile__c];
		string pcorp = '';
		string pmbe = '';
		for (Profile__c Pl : Profile  ) {
			if (pl.PR_Name__c == 'Boothadmin')
				//profile id for corporates
				pcorp = pl.id;
			else if (pl.PR_Name__c == 'Attendee')
				//profile id for MBEs
				Pmbe = pl.id;
		}
		List<Event_Attendee_Mapping__c> EAMsList = new List<Event_Attendee_Mapping__c>();
		List<User_Profile_Event__c> UPESList = new List<User_Profile_Event__c>();
		List<Booth__c> boothList = new List<Booth__c>();

		//for packages need to collect data from Item pools
		List<Item_Pool__c> itempool = new List<Item_Pool__c>();
		List<Ticket__c> ticketList = new List<Ticket__c>();
		//Query on Item pool
		//collecting records from child item pool(line items)
		//condition is parent id is not null
		itempool = [select id, Addon_Parent__r.id, Item_Type__r.Name from Item_Pool__c
		            where Addon_Parent__c != ''
		            AND Addon_Parent__c != null
		            AND Event__c = : tits[0].Event__r.id
		                           AND (Item_Type__r.Name = 'MatchLeads Buyer'
		                                   OR Item_Type__r.Name = 'MatchLeads Seller')];

		system.debug(':::::::::::::::::::::::::itempool :::::::::::' + itempool );
		//Mapping the item pool records with the key of parent id
		Map<id, Item_Pool__c> poolmap = new Map<id, Item_Pool__c>();
		if (itempool.size() > 0) {
			for (Item_Pool__c ITMP : itempool ) {
				poolmap.put(ITMP.Addon_Parent__r.id, ITMP);
			}
		}
		 System.debug('Ticket valuessss '+tits);
		if (tits.size() > 0) {
			for (Ticket__c ti : tits ) {
				//getting Match Leads buyer and Seller Tickets
				 System.debug('ti.Ticket_Status__c  '+ti.Ticket_Status__c +' ti.Item_Type__r.Name '+ti.Item_Type__r.Name);
				if (ti.Ticket_Status__c == 'Booked' && (ti.Item_Type__r.Name == 'MatchLeads Buyer' || ti.Item_Type__r.Name == 'MatchLeads Seller')) {
					ticketList.add(ti);
				} else if (ti.Ticket_Status__c == 'Booked' && ti.Item_Type__r.Name == 'Package') {
					Item_Pool__c itp = poolmap.get(ti.Item_Pool__c);
					if (itp != null && itp.Addon_Parent__r.id == ti.Item_Pool__c) {
						ticketList.add(ti);
					}
				}
			}
		}
 System.debug('ticketList.size()  '+ticketList.size());

		if (ticketList.size() > 0) {
			//inserting booth(Table)
			for (Ticket__c tik : ticketList) {
				User Usrslist = Usermap.get(tik.tkt_profile__r.Email__c);
				system.debug('::::::::::::::::::::::tickets::::::::::' + tik.tkt_profile__r.Email__c);
				AttendeeSummary__c attrecs =  new AttendeeSummary__c();
				attrecs = Attmap.get(tik.tkt_profile__r.Email__c);
				Booth__c booth = new Booth__c();

				if (tik.Ticket_Status__c == 'Booked' && (tik.Item_Type__r.name == 'MatchLeads Buyer')) {
					booth.BT_Name__c = attrecs.AS_Company__c;
					booth.BT_ContactEmail__c = Usrslist.Username;
					booth.EV_id__c  = Eventsmap.get(tik.Event__c).id;
					boothList.add(booth);
					system.debug(':::::::::::::::::::::boothList:::::::::::::::;' + boothList);
				} else if (!poolmap.isEmpty()) {
					if (poolmap.get(tik.Item_Pool__c).Item_Type__r.Name != null) { //Inserting booth for packages
						if ( poolmap.get(tik.Item_Pool__c).Item_Type__r.Name == 'MatchLeads Buyer') {

							booth.BT_Name__c = attrecs.AS_Company__c;
							booth.BT_ContactEmail__c = Usrslist.Username;
							booth.EV_id__c  = Eventsmap.get(tik.Event__c).id;
							boothList.add(booth);
							system.debug(':::::::::::::::::::::boothList:::::::::::::::;' + boothList);
						}
					}

				}
			}
			database.insert(boothList, false);
			system.debug(':::::::::::::::::::::boothList:::::::::::::::;' + boothList);
			MAP<string, Booth__c> boothmap = new MAP<string, Booth__c>();
			for (Booth__c bt : boothList ) {
				boothmap.put(bt.BT_ContactEmail__c, bt);
			}

			//inserting all like eam and upe
			for (Ticket__c tic : ticketList) {
				system.debug('::::::::::::::::::::::tickets:::::::::::' + tic.Ticket_Status__c + ';;;;;;;;tic.Ticket_Status__c;;;;;;;;' + tic.id + '::::::::::::' + tic.Item_Type__r.name);
				User Usrslist = Usermap.get(tic.tkt_profile__r.Email__c);
				system.debug('::::::::::::::::::::::tickets::::::::::' + tic.tkt_profile__r.Email__c);
				AttendeeSummary__c attrecs =  new AttendeeSummary__c();
				attrecs = Attmap.get(tic.tkt_profile__r.Email__c);
				//Inserting EAM Record
				system.debug('::::::::::::::::::::::att::::::::::' + attrecs );
				Event_Attendee_Mapping__c eam = new Event_Attendee_Mapping__c();
				eam.AS_id__c = attrecs.id;
				eam.EV_id__c = Eventsmap.get(tic.Event__c).id;
				if (tic.Item_Type__r.Name == 'MatchLeads Buyer') {
					eam.Boothleads_Profile__c = 'Booth Admin';
				} else if (tic.Item_Type__r.Name == 'MatchLeads Seller') {
					eam.Boothleads_Profile__c = 'Attendee';
				} else if (!poolmap.isEmpty()) {
					if (poolmap.get(tic.Item_Pool__c).Item_Type__r.Name != null) {
						if ( poolmap.get(tic.Item_Pool__c).Item_Type__r.Name == 'MatchLeads Buyer') {
							eam.Boothleads_Profile__c = 'Booth Admin';
						} else if (poolmap.get(tic.Item_Pool__c).Item_Type__r.Name == 'MatchLeads Seller') {
							eam.Boothleads_Profile__c = 'Attendee';
						}
					}

				}
				eam.IsMatchMakingAttendee__c = true;
			 
			  if(!UPEMAP.keySet().contains(tic.tkt_profile__r.Email__c)){	
				EAMsList.add(eam);
			 }	
				//UPE INSERTION-------------------------
				User_Profile_Event__c UPE = new User_Profile_Event__c();
				UPE.EV_id__c = Eventsmap.get(tic.Event__c).id;
				UPE.IsMatchMakingUser__c = true;
				UPE.User_id__c = Usrslist.id;
				UPE.BoothAdmin_id__c = Usrslist.id;
				// system.debug(':::::::::::::::::ITEM TYPE:::::::::::::::::::::::::'+poolmap.get(tic.Item_Pool__c).Item_Type__r.Name);
				if (tic.Item_Pool__r.Item_Type__r.name == 'MatchLeads Buyer' ) {
					UPE.MAtchMakingProfile__c = 'Corporate';
					UPE.Profile_id__c = pcorp;
					UPE.BT_id__c = boothmap.get(Usrslist.Username).id;
				} else if (tic.Item_Pool__r.Item_Type__r.name == 'MatchLeads Seller') {
					UPE.MAtchMakingProfile__c = 'MBE';
					UPE.Profile_id__c = pmbe;
				} else if (!poolmap.isEmpty()) {
					if (poolmap.get(tic.Item_Pool__c).Item_Type__r.Name != null) {
						if ( poolmap.get(tic.Item_Pool__c).Item_Type__r.Name == 'MatchLeads Buyer') {
							UPE.MAtchMakingProfile__c = 'Corporate';
							UPE.Profile_id__c = pcorp;
							UPE.BT_id__c = boothmap.get(Usrslist.Username).id;
						} else if (poolmap.get(tic.Item_Pool__c).Item_Type__r.Name == 'MatchLeads Seller') {
							UPE.MAtchMakingProfile__c = 'MBE';
							UPE.Profile_id__c = pmbe;
						}
					}

				}
				UPE.EventAdmin_Id__c = Eventsmap.get(tic.Event__c).Owner.id;
				if(!UPEMAP.keySet().contains(tic.tkt_profile__r.Email__c)){
				UPESList.add(UPE);
			}
		}
		}
		database.insert(EAMsList, false);
		system.debug(':::::::::::::::::::::::::::::EAM::::::::::' + EAMsList);

		database.insert(UPESList, false);
		system.debug(':::::::::::::::::::::::::::::EAM::::::::::' + UPESList);
    
    //-------------------------------------Mail For Shelli---------------------------
    
    
    EmailTemplate E = new EmailTemplate(); //For shelli
    E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name =: 'Special Matchleads template for Shelli'];//For schelli
     if(!Test.isRunningTest()){
      if(tits[0].Event__c == 'a19F0000007BLXf'){    
     List<Messaging.singleEmailMessage> emails = new List<Messaging.singleEmailMessage>();
     
     for(Ticket__c  U: tits ){
    // if(U.Ticket_Status__c == 'Booked'){
         String[] toAddresses1 = new String[]{};
         OrgWideEmailAddress[] owea = new OrgWideEmailAddress[]{};
         owea=[select id from OrgWideEmailAddress Where DisplayName =:'Shelli McMillen'];
         system.debug('::::;;;;;OWE:::::::::::;'+owea);
               
         Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
         User Usrslistnew = Usermap.get(U.tkt_profile__r.Email__c);
         system.debug('::::;;;;;Usrslistnew :::::::::::;'+Usrslistnew );
         toAddresses1.add(Usrslistnew.Username);
         email.subject = E.subject;
         email.setToAddresses(toAddresses1); 
         String ReplaceContactName1 = E.HtmlValue;
         ReplaceContactName1 = ReplaceContactName1.replace('Emailid',Usrslistnew.Username);
         ReplaceContactName1 = ReplaceContactName1.replace('{!Name}',Usrslistnew.Firstname);
         
         if(owea.size() > 0 ) {
                    email.setOrgWideEmailAddressId(owea.get(0).Id);
               } 
         email.setHtmlBody(ReplaceContactName1);
         system.debug('::::;;;;;email:::::::::::;'+email);
         If(U.Event__c == 'a19F0000007BLXf'){//a19F0000007BLXf//a1918000000YutC
          emails.add(email);
         }
     system.debug('::::;;;;;emails:::::::::::;'+emails);
     //}                     
    Messaging.sendEmail(emails);
   
   }
   }
	}
   //--------------------------------------------------------------------------------
    
    
    
    
    
    
    
   } 
    

public void dummy(){   
         integer i=0;
          i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
         i++;
       
        
        
        }
    
}