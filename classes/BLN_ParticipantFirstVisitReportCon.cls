public class BLN_ParticipantFirstVisitReportCon {

/****************************************************************
Author    : Deepthi K
Date      : 10 Mar 2016
Purpose   : Report to display when pre-registered participants 
            visited for the first time
****************************************************************/

    public BLN_Event__c  se{get;set;}
    public String SelectedEvent{get; set;}
    public BLN_UtillDisplayLinks myticket { get; set; }
    public transient LIST<ticket__c> ticketsList{get;set;}
    
    public BLN_ParticipantFirstVisitReportCon(){
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
        if(k!=null){ 
         selectedEvent = k.getValue();
        }
        
        LIST<ticket__c> ticList = new LIST<ticket__c>();
        ticList = [SELECT name,Order__c,item_pool__r.item_pool_name__c,tkt_profile__r.First_Name__c,tkt_Profile__r.Last_Name__c,tkt_profile__r.Email__c,tkt_profile__r.TKT_Company__c,(select scan_time__c from tstatus__r order by scan_time__c ASC limit 1) from ticket__c 
                        WHERE event__c = :selectedEvent 
                         AND tstatus_id__c != ''];
                         
        LIST<Payment__c> payments = new LIST<Payment__c>();
        BLN_Payment_DAO payDAO = new BLN_Payment_DAO();
        payments = payDAO.allpaymentsForEvent(selectedEvent);
        
        MAP<id,string> orderPayMap = new MAP<id,string>();
        for(Payment__c p:payments){
            orderPayMap.put(p.order__c,p.Registration_Type__c);
        }
        
        ticketsList = new LIST<ticket__c>();
        for(ticket__c t:ticList){
            if(orderPayMap.get(t.order__c)!= 'Onsite'){
                ticketsList.add(t);
            }
        }
        
    }
    
    
    public PageReference displayPermissions() {
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
        if(k!=null){ 
         selectedEvent = k.getValue();
        }
        
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
        se = new BLN_Event__c  ();
        try{
         se = blneventdetailbal.eventdetails(selectedEvent );
        }catch(exception e){}
        
        myticket = new BLN_UtillDisplayLinks();
        myticket.isSAExpand='expand';
        myticket.isSAreportExpand='expand';
        myticket.isFirstVisitReportPage='active';
        myticket.tablabel='First Visit Report';
        myticket.EventId = selectedEvent ;
        try{
          myticket.eventName=se.NAme;
        }catch(exception e){}
        myticket.userPermissions(userInfo.getUserId(),selectedEvent);
        return null;
    }
    
    public PageReference userSelectPerticularToExport() {
        pageReference pg = new PageReference ('/apex/BLN_ParticipantFirstVisitReportExport');
        pg.getParameters().put('seldates',apexpages.currentpage().getparameters().get('seldates'));
        pg.setRedirect(true);
        return pg;
    }

    public string seldates{get;set;}
    public PageReference expmethod() {
        seldates=apexpages.currentpage().getparameters().get('seldates');
        system.debug(apexpages.currentpage().getparameters().get('seldates')+'sssssssddddddd'+seldates);
    if(seldates!=null && seldates!=''){
        LIST<ticket__c> ticList = new LIST<ticket__c>();
        for(ticket__c t:ticketsList){
            if(seldates.contains(t.item_pool__r.item_pool_name__c)){
                ticList.add(t);
            }
        }
        ticketsList = new LIST<ticket__c>();
        ticketsList.addAll(ticList);
    }
    system.debug('1111111:');
        return null;
    }   
}