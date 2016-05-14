public class BLN_notCheckedinParticipantsReport_BAL{
    
    public LIST<BLN_CheckInHistoryDetails> getParticipants(string selectedEvent,string selectedTicketName,string regtype){
        BLN_Ticket_DAO ticDAO=new BLN_Ticket_DAO();
        string whereCondition='';
        LIST<BLN_CheckInHistoryDetails> ticClas= new LIST<BLN_CheckInHistoryDetails>();
        LIST<ticket__c> ticketDetails = new LIST<ticket__c>();
        
        LIST<Payment__c> payments = new LIST<Payment__c>();
        BLN_Payment_DAO payDAO = new BLN_Payment_DAO();
        payments = payDAO.allpaymentsForEvent(selectedEvent);
        
        MAP<id,string> orderPayMap = new MAP<id,string>();
        for(Payment__c p:payments){
            orderPayMap.put(p.order__c,p.Registration_Type__c);
        }
        
        whereCondition=' WHERE event__r.id = \''+selectedEvent+'\''+' AND ticket_status__c =\'Booked\' AND (Tstatus_Id__c =\'\' OR Tstatus_Id__c=null)  AND Order__r.Order_Status__c != \'Cancelled\' AND Order__r.Order_Status__c != \'Abandoned\'' ;
        if(selectedTicketName != 'Ticket Name')
        whereCondition+=' AND Item_Pool__r.Item_Pool_Name__c =\''+selectedTicketName+'\'';
        ticketDetails = ticDAO.userOrderAndTickets(whereCondition);
    
        string ticname='';
        string tname1='';
        set<string> ticnames = new set<string>();
        List<Ticket__c> tclist1 = new List<Ticket__c>();
         for(Ticket__c tds:ticketDetails)
         {
            //if(orderPayMap.get(tds.order__c)!='Onsite'){
            if((orderPayMap.get(tds.order__c)==regtype && regtype != 'Registration Type') || (regtype == 'Registration Type')){
            ticname=tds.Item_Pool__r.Item_Pool_Name__c;
            if(!ticnames.contains(ticname)){  
             ticnames.add(ticname);
             tclist1.add(tds);
           }
           }
        }
  
        for (Ticket__c tc :tclist1){
            list<ticket__c> grpticsList=new list<ticket__c>();
             for(Ticket__c tds1:ticketDetails)
             {
                 //if(orderPayMap.get(tds1.order__c)!='Onsite'){
                 if((orderPayMap.get(tds1.order__c)==regtype && regtype != 'Registration Type') || (regtype == 'Registration Type')){
                 string tn = tc.Item_Pool__r.Item_Pool_Name__c;
                 tname1 = tds1.Item_Pool__r.Item_Pool_Name__c;
                 system.debug('n1-----'+tn+'----n2----'+tname1);
                 if(tn == tname1)
                 {
                     grpticsList.add(tds1);
                 }
                 }
              }
             ticClas.add(new BLN_CheckInHistoryDetails(tc, grpticsList));
         }
        return ticClas;
    }
    
    public class BLN_CheckInHistoryDetails {
       public Ticket__c GuestName{get;set;}
       public list<Ticket__c> tcinn{get;set;}

       // Constructor Loads the chekin checkout details for each ticket  for the given guest.
       public BLN_CheckInHistoryDetails(Ticket__c GuestName1,list<Ticket__c> grpticsList){
          GuestName=GuestName1;
          tcinn=grpticsList;

          }
    }

}