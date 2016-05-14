@RestResource(urlMapping = '/BLN_ASC_ED_Attendeeloadmore/*')
global class BLN_ASC_ED_Attendeeloadmore {
	@HttpPost
	global Static List<BLN_ASC_Utillcls.TicketInfo>  doPost() {
		RestRequest req = RestContext.request;
		String eventid = req.params.get('Event_id');
		String lastAttId = req.params.get('lastattid');
		List<BLN_ASC_Utillcls.TicketInfo> TicketInfoList = new List<BLN_ASC_Utillcls.TicketInfo>();
		BLN_PromoCode_BAL promo =new BLN_PromoCode_BAL();
		BLN_Event__c se = new BLN_Event__c(); 
		se = promo.eventdetails(eventid);
		integer limitval =0;
		 if(se.scan_attendee_limit__c!=null){
		   limitval =integer.valueOf(se.scan_attendee_limit__c);
		  } 
		TicketInfoList = BLN_Utill_BAL.getAttendees(eventid, lastAttId,limitval,null);
		return TicketInfoList;
	}
}