public with sharing class BLN_app_settings_BAL{
     public BLN_Ticket_DAO ticDAO{get;set;}
    public boolean MMBuyerflag{get;set;}
    public boolean MMSellerflag{get;set;}
    public boolean LeadRetrivalflag{get;set;}
    public boolean FloorMapflag{get;set;}
    public boolean Seminarsflag{get;set;}
    public boolean Exhibitorflag{get;set;}
    public boolean Sponsorsflag{get;set;}
    public boolean Speakersflag{get;set;}
    public boolean Scanattendeeflag{get;set;}
    
    public MAP<String,Boolean> checkticdetails(string eventid){
    //ticDAO=new BLN_Ticket_DAO();
     MAP<String,Boolean> mapLabelWithinc = new MAP<String,Boolean>(); 
      BLN_ItemPool_DAO ticDAO = new BLN_ItemPool_DAO();
     string selectedeventid = eventid;
     //LIST<Ticket__c> tic = ticDAO.gettlist(selectedeventid);
     //[SELECT Item_Pool__r.Item_Type__r.Name,Item_Type__r.Name,Order__r.Order_Status__c FROM Ticket__c WHERE Event__c = :selectedeventid AND Ticket_Status__c!='Cancelled'];
     LIST<Item_Pool__c> tic = ticDAO.getPoolsBlongthatevent(selectedeventid);

      MMBuyerflag = false;
      MMSellerflag = false;
      LeadRetrivalflag = false;
      FloorMapflag = false; 
      Seminarsflag = false;
      Exhibitorflag= false;
      Sponsorsflag=false;
      Speakersflag=false;
      Scanattendeeflag=false;
      
     //mapLabelWithinc.put(); 
     mapLabelWithinc.put('MatchLeads',MMBuyerflag);
     mapLabelWithinc.put('Lead Retrieval',LeadRetrivalflag);
     mapLabelWithinc.put('Floor Map',FloorMapflag);
     mapLabelWithinc.put('Seminars',Seminarsflag);
     mapLabelWithinc.put('Exhibitors',Exhibitorflag);
     mapLabelWithinc.put('Sponsors',Sponsorsflag); 
     mapLabelWithinc.put('Speakers',Speakersflag); 
     mapLabelWithinc.put('Scan Attendee',Scanattendeeflag);
     
     for(Item_Pool__c t:tic){
      
      if((t.Item_Type__r.Name == 'Scan Attendee') ){
           MMBuyerflag = true;
           Scanattendeeflag =true;
           mapLabelWithinc.put('Scan Attendee',Scanattendeeflag);
       }
     
       if((t.Item_Type__r.Name == 'MatchLeads Buyer') ){
           MMBuyerflag = true;
           mapLabelWithinc.put('MatchLeads',MMBuyerflag);
       }
       
       if((t.Item_Type__r.Name == 'MatchLeads Seller')){
           MMSellerflag = true; 
           mapLabelWithinc.put('MatchLeads',MMSellerflag);
       }
       
       if((t.Item_Type__r.Name == 'Lead Retrieval')){
           LeadRetrivalflag = true; 
           mapLabelWithinc.put('Lead Retrieval',LeadRetrivalflag);
       }
       
       if((t.Item_Type__r.Name =='Booth Map')){
           FloorMapflag = true; 
           mapLabelWithinc.put('Floor Map',FloorMapflag);
       }
           if(t.Item_Type__r.Name == 'Seminars' ){
           Seminarsflag = true;
            mapLabelWithinc.put('Seminars',Seminarsflag);
           }
           if(t.Item_Type__r.Name == 'Booths /Tables'){
               Exhibitorflag= true;
              mapLabelWithinc.put('Exhibitors',Exhibitorflag); 
           }
           if(t.Item_Type__r.Name == 'Sponsorship' ){
               Sponsorsflag=true;
               mapLabelWithinc.put('Sponsors',Sponsorsflag); 
           }
           if(t.Item_Type__r.Name == 'Speaker'){
               Speakersflag=true;
              mapLabelWithinc.put('Speakers',Speakersflag); 
           }
       
       system.debug('aaaaaaaaaaaaa'+Sponsorsflag);
     
     }
     
     return mapLabelWithinc;
    
    }

}