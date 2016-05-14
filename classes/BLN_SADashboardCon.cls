public with sharing class BLN_SADashboardCon {
/***************************************************************
    *   Controller Name         : BLN_SADashboardCon
    *   Date                    : 16March 2016 
    *   Author                  : Unni Krishna
    *   Purpose                 : This class is for Creating Scan Attendee Dashboards.
******************************************************************/

    public BLN_UtillDisplayLinks   myticket { get; set; }
    public string selectedEventId{get;set;}
    public BLN_Ticket_DAO ticDAO{get;set;}
    public BLN_Ticket_DAO ticDAO1{get;set;}

    //for scan attendee
    public Event__c SelectedEvent{get; set;}
    public Integer NoofAttendees{get;set;}
    public Integer NoOfTicketsSold{get;set;}
    public Integer NoOfItemsSold{get;set;}
    public Decimal Revenue{get;set;}
    public Integer NoOfcheckins{get;set;}
    public Boolean isPastEvent{get; set;}     
    public Boolean isEventAdminStaffUser{get; set;}  
    public Boolean EAbool{get; set;} 
 
//CONSTRUCTOR
    public BLN_SADashboardCon(){
    try{
    Cookie k = ApexPages.currentPage().getCookies().get('counter');
        if(k!=null){ 
            selectedEventId = k.getValue();
        }
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
    BLN_Event__c  se = new BLN_Event__c  ();
    try{
    se = blneventdetailbal.eventdetails(selectedEventId );
    
       }catch(exception e){}
    
    myticket = new BLN_UtillDisplayLinks();
    myticket.isSADashboardPage='active';
    myticket.isSAExpand='expand';
    myticket.isEventAdmin= true;
    myticket.tablabel='Scan Attendee Dashboard';
    myticket.eventId=selectedEventId;
    
    try{
    myticket.eventName=se.NAme;
    }catch(exception e){}
    myticket.userPermissions(userInfo.getUserId(),selectedEventId);
        EAbool=false;
        
     id id1 = userinfo.getProfileId();
     system.debug('ProfileId'+id1);
     profile p1=[select Name from profile where id = :id1];
     
    if(se.Organizer_Email__c ==userInfo.getUserName()||se.OwnerId==userinfo.getuserid()) 
         EAbool=true;

    restoftheQueries();
    

         
    }
    catch(exception ex){}

    }  
    
    public Pagereference restoftheQueries()
    {
      //for scan attendee dashboard
      Statistics();
      checkInStatus();

      return null; 
    }   

  //for scan attendee dashboard
   public transient LIST<Ticket__c> ticketDetails{get; set;}
   public  transient  LIST<Ticket__c> ticketDetails1{get; set;}
   public Integer TotalCheckins{get; set;}
  
   public Decimal CheckedInPercent{get; set;}
   public BLN_Ticket_DAO ticDAO2{get; set;}
   
   public void Statistics(){
      ticDAO1= new BLN_Ticket_DAO();
       ticketDetails  = new LIST<Ticket__c>();
        string temp1=' WHERE event__r.id = \''+selectedEventId+'\''+'AND Ticket_Status__c!=\'Cancelled\' AND Ticket_Status__c = \'Booked\'';
        //if scan attendee session
        if(EAbool!=true)
        {
        List<BLN_Scanusr_item__c > sc=[select id,name,BLN_GN_User__c,BLN_GN_User__r.User__r.email,BLN_Event__c,BLN_Item_Pool__c from BLN_Scanusr_item__c where BLN_GN_User__r.User__r.email=:UserInfo.getUserEmail() and BLN_Event__c=:selectedEventId and BLN_Item_Pool__c!=null];
        if(sc.size()>0)
        {
          String idInClause = '(\'';
          for(BLN_Scanusr_item__c s:sc)
          idInClause += s.BLN_Item_Pool__c + '\',\'';
          idInClause  = idInClause.substring(0,idInClause.length()-2);
          idInClause += ')';
          temp1=' WHERE event__r.id = \''+selectedEventId+'\''+' AND Ticket_Status__c!=\'Cancelled\' AND Ticket_Status__c = \'Booked\' and Item_Pool__c in'+idInClause ;
          
          
        }
        }
        //
        ticketDetails = ticDAO1.userOrderAndTickets(temp1);
        
       string s2='Scan Attendee';
       ticDAO2= new BLN_Ticket_DAO();
       ticketDetails1  = new LIST<Ticket__c>();
       string temp2=' WHERE event__r.id = \''+selectedEventId+'\''+'AND Ticket_Status__c!=\'Cancelled\' AND Ticket_Status__c = \'Booked\' AND Item_Pool__r.Item_Type__r.Name =\''+s2+'\'';
       ticketDetails1 = ticDAO2.userOrderAndTickets(temp2);
       
       NoOfcheckins = 0;
      
       TotalCheckins= 0;
       
       
       list<tstatus__C> TotalCheckinsCnt= [SELECT Tstatus_name__c, Ticket__r.TKT_Profile__r.Email__c
                                                FROM Tstatus__c
                                                WHERE Ticket__c IN : ticketDetails
                                                order by lastmodifieddate desc];

       
       set<string> em = new set<string>();
       for(tstatus__c ts:TotalCheckinsCnt){
           if(!em.contains(ts.Ticket__c)){
               em.add(ts.Ticket__c);
               TotalCheckins++;
               if(ts.Tstatus_name__c==true)
                   NoOfcheckins++;
           }
       
       }                              

        checkinStatisticsInnerList = new LIST<checkinStatisticsInner>();
        if(NoOfcheckins !=0 || TotalCheckins!=0){
                checkinStatisticsInnerList.add(new checkinStatisticsInner('Total', TotalCheckins));
                checkinStatisticsInnerList.add(new checkinStatisticsInner('CheckedIns', NoOfcheckins));
            }    
            CheckedInPercent=0;
            if(NoOfcheckins !=0 && TotalCheckins!=0){
                CheckedInPercent= (NoOfcheckins*100)/TotalCheckins;
                CheckedInPercent= CheckedInPercent.setscale(2);            
        }
   
   
   }
  
  
  
   public transient LIST<checkinStatisticsInner> checkinStatisticsInnerList{get; set;}
    
    public class checkinStatisticsInner{
        
        public String statisticsName{get; set;}
        public Decimal statisticsCount{get; set;}
        
        public checkinStatisticsInner(String statisticsName, Decimal statisticsCount){
            this.statisticsName= statisticsName;
            this.statisticsCount= statisticsCount;
        }
    }
  
     // public LIST<AggregateResult> CheckInStatusList{get; set;}
     public transient list<ticket__c> tcs{get;set;}
     public void checkInStatus(){
    //if scan attendee session
     if(EAbool!=true)
        {
        List<BLN_Scanusr_item__c > sc=[select id,name,BLN_GN_User__c,BLN_GN_User__r.User__r.email,BLN_Event__c,BLN_Item_Pool__c from BLN_Scanusr_item__c where BLN_GN_User__r.User__r.email=:UserInfo.getUserEmail() and BLN_Event__c=:selectedEventId and BLN_Item_Pool__c!=null];
        if(sc.size()>0)
        {
          List<String> poolids=new List<String>();
          for(BLN_Scanusr_item__c s:sc)
          poolids.add(s.BLN_Item_Pool__c);
          tcs= [select Item_Pool__r.Item_Pool_Name__c,item_pool__c,tstatus_id__c,tstatus_id__r.Tstatus_name__c,TKT_Profile__r.Email__c,(SELECT Tstatus_name__c from tstatus__r order by lastmodifieddate) from ticket__c 
               where Ticket_Status__c != 'Cancelled'
                 AND Ticket_Status__c = 'BOOKED'
                 AND order__r.order_type__c!='EVENT PRODUCER'
                 AND Event__c =: selectedEventId and item_pool__c in:poolids order by Item_Pool__r.Item_Pool_Name__c];
         }
        else
        //
    tcs= [select Ticket_Status__c,Item_Pool__r.Item_Pool_Name__c,tstatus_id__c,tstatus_id__r.Tstatus_name__c,TKT_Profile__r.Email__c,(SELECT Tstatus_name__c from tstatus__r order by lastmodifieddate) from ticket__c 
               where Ticket_Status__c != 'Cancelled'
                 AND Ticket_Status__c = 'BOOKED'
                 AND order__r.order_type__c!='EVENT PRODUCER'
                 AND Event__c =: selectedEventId order by Item_Pool__r.Item_Pool_Name__c];
                 }
                 else
                 tcs= [select Ticket_Status__c,Item_Pool__r.Item_Pool_Name__c,tstatus_id__c,tstatus_id__r.Tstatus_name__c,TKT_Profile__r.Email__c,(SELECT Tstatus_name__c from tstatus__r order by lastmodifieddate) from ticket__c 
               where Ticket_Status__c != 'Cancelled'
                 AND Ticket_Status__c = 'BOOKED'
                 AND order__r.order_type__c!='EVENT PRODUCER'
                 AND Event__c =: selectedEventId order by Item_Pool__r.Item_Pool_Name__c];
                 
                 
        set<string> tname= new set<string>();
        for(ticket__c tic:tcs){
            if(!tname.contains(tic.Item_Pool__r.Item_Pool_Name__c)){
                tname.add(tic.Item_Pool__r.Item_Pool_Name__c);
            }
        }
        CheckInInnerList= new LIST<CheckInInner>();
        
        for(string t:tname){
            Integer checkIn= 0;
            Integer notCheckIn= 0;
            for(ticket__c tic:tcs){
                if(t==tic.Item_Pool__r.Item_Pool_Name__c){//&& tstatus_id__c != null){
                        if(tic.tstatus_id__r.Tstatus_name__c == true){
                        system.debug('tic.Item_Pool__r.Item_Pool_Name__c'+tic+' ci '+checkIN);
                            checkIn++;
                        }else{
                        system.debug('tic.Item_Pool__r.Item_Pool_Name__c'+tic+' nci '+notcheckIN);
                            notCheckIn++;
                        }
                }
            }
            if(t.length() >15){
                t= t.substring(0,14)+' ...';
            }
            CheckInInnerList.add(new CheckInInner(t, checkIn, notCheckIn));
        
        }
    
        
        
        
    
    }
  
   public transient LIST<CheckInInner> CheckInInnerList{get; set;}
    public class CheckInInner{
    
        public String ticName{get; set;}
        public Integer CheckInCount{get; set;}
        public Integer NotCheckInCount{get; set;}    
            
        public CheckInInner(String ticName, Integer CheckInCount, Integer NotCheckInCount){
            
            this.ticName= ticName;
            this.CheckInCount= CheckInCount;
            this.NotCheckInCount= NotCheckInCount;
            system.debug(ticName+' INNER CLASS '+CheckInCount);
        
        }
    
    } 
    
    

}