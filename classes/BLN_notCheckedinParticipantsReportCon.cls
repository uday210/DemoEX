public class BLN_notCheckedinParticipantsReportCon {

/****************************************************************
Author    : Deepthi K
Date      : 09 Mar 2016
Purpose   : Report to display pre-registered participants who have 
            not checked in
****************************************************************/
    public BLN_UtillDisplayLinks myticket { get; set; }
    public BLN_Event__c  se{get;set;}
    public String SelectedEvent{get; set;}
    //public LIST<ticket__c> ticList{get;set;}
    public transient LIST<BLN_notCheckedinParticipantsReport_BAL.BLN_CheckInHistoryDetails> innCls{get;set;}
    public transient LIST<BLN_notCheckedinParticipantsReport_BAL.BLN_CheckInHistoryDetails> innClsExport{get;set;}

    public BLN_notCheckedinParticipantsReportCon(){
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
        if(k!=null){ 
         selectedEvent = k.getValue();
        }
        
        selectedTicketName= 'Ticket Name';
        selectedpaymentFilterType='Registration Type';
        filterticketname();
        filterRegType();
        
        //ticList = new LIST<ticket__c>();
        BLN_notCheckedinParticipantsReport_BAL ncBAL = new BLN_notCheckedinParticipantsReport_BAL();
        inncls = new LIST<BLN_notCheckedinParticipantsReport_BAL.BLN_CheckInHistoryDetails>();
        inncls = ncBAL.getParticipants(selectedEvent,selectedTicketName,selectedpaymentFilterType);
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
        myticket.isnotCheckinReportPage='active';
        myticket.tablabel='Not Checked In Report';
        myticket.EventId = selectedEvent ;
        try{
          myticket.eventName=se.NAme;
        }catch(exception e){}
        myticket.userPermissions(userInfo.getUserId(),selectedEvent);
        return null;
    }
    
     public pageReference  userSelectPerticularToExport(){
         system.debug('selectedTicketName'+selectedTicketName);
        BLN_notCheckedinParticipantsReport_BAL ncBAL = new BLN_notCheckedinParticipantsReport_BAL();
        innclsExport = new LIST<BLN_notCheckedinParticipantsReport_BAL.BLN_CheckInHistoryDetails>();
        innclsExport = ncBAL.getParticipants(selectedEvent,selectedTicketName,selectedpaymentFilterType);
        pageReference pg = new PageReference ('/apex/BLN_exportnotCheckedinParticipantsReport');
        return pg; 
     } 
     
    public LIST<SelectOption> Ticketnamefilter{get; set;}
    public String selectedTicketName{get; set;}
    
    public list<SelectOption> filterticketname(){
          set<string> ticset = new set<string>();
          list<Ticket__c> ticlis = new list<Ticket__c>();
          ticlis = [select id, name,Item_Pool__r.Item_Pool_Name__c from Ticket__c where Event__c =:selectedEvent AND Tstatus_Id__c= null AND Ticket_Status__c =: 'Booked'];
          for(Ticket__c tic : ticlis){
              ticset.add(tic.Item_Pool__r.Item_Pool_Name__c);
          }
          Ticketnamefilter = new list<SelectOption>();
          Ticketnamefilter.add(new SelectOption('Ticket Name','Ticket Name'));
            for(string tc: ticset)
            {
               Ticketnamefilter.add(new SelectOption(tc,tc));
            }
            
            return Ticketnamefilter;
    }
    
    public LIST<SelectOption> paymentfilterTypes{get; set;}
    public String selectedpaymentFilterType{get; set;}
    
    public list<SelectOption> filterRegType(){
        set<string> RegTypeset = new set<string>();
        list<Payment__c> paylis = new list<Payment__c>();
        paymentfilterTypes= new LIST<SelectOption>();
        paymentfilterTypes.add(new SelectOption('Registration Type','Registration Type'));
        
        paylis = [select id,Registration_Type__c from Payment__c where order__r.Events__c =:selectedEvent AND order__r.Order_Status__c != 'Cancelled' AND order__r.Order_Status__c != 'Abandoned'];
        for(Payment__c pay : paylis){
            if(!RegTypeset.contains(pay.Registration_Type__c)){
                RegTypeset.add(pay.Registration_Type__c);
                if(pay.Registration_Type__c != 'Mobile')
                paymentfilterTypes.add(new SelectOption(pay.Registration_Type__c,pay.Registration_Type__c));
                if(pay.Registration_Type__c == 'Mobile')
                paymentfilterTypes.add(new SelectOption(pay.Registration_Type__c,'Scan Attendee'));
            }
        }
        return paymentfilterTypes;
    }
    
    
    public void filtermethod() {
        BLN_notCheckedinParticipantsReport_BAL ncBAL = new BLN_notCheckedinParticipantsReport_BAL();
        inncls = new LIST<BLN_notCheckedinParticipantsReport_BAL.BLN_CheckInHistoryDetails>();
        inncls = ncBAL.getParticipants(selectedEvent,selectedTicketName,selectedpaymentFilterType);
        //pagereference pg=page.BLN_notCheckedinParticipantsReport;
        //return null;
    }
    
}