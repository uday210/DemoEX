@RestResource(urlMapping='/BLN_ASC_ED_SearchAttendee/*')
global class BLN_ASC_ED_SearchAttendee {
   @HttpPost
    global static List<BLN_ASC_Utillcls.TicketInfo> searchAtt(){
       RestRequest req = RestContext.request;  
       String search_string = req.params.get('search_string');
       String userId = req.params.get('User_id');
       String eventid = req.params.get('Event_id');
       BLN_Mytickets_BAL myticketsBal = new BLN_Mytickets_BAL();
       myticketsBal.searchstring=search_string;
       List<BLN_ASC_Utillcls.TicketInfo> TicketInfoList = new List<BLN_ASC_Utillcls.TicketInfo>();
       LIST<BLN_Mytickets_BAL.inncls>  inlists = myticketsBal.userTickets(userId,eventid,'BLN_ASC_ED_SearchAttendee','');
        List<Ticket__c> tkts = new List<Ticket__c>();
       for (BLN_Mytickets_BAL.inncls inc : inlists) {
          tkts.AddAll(inc.ticketsInn);
       } 
       for (Ticket__c tc : tkts) {
            TicketInfoList.add(new BLN_ASC_Utillcls.TicketInfo(tc));
        }
       return TicketInfoList;
    }
}