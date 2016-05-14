public with sharing class BLN_CheckinHistoryReportService {

  public BLN_Ticket_DAO ticDAO{get;set;}
   public LIST<Ticket__c> ticketDetails{get; set;}
   
    public LIST<BLN_CheckInHistoryDetails>  TicketCheckInHistory(LIST<Ticket__c> ticketDetails1,String selectedFilterType,string regtype,string selectedEvent,string scannedby){    

       LIST<BLN_CheckInHistoryDetails> ticClas= new LIST<BLN_CheckInHistoryDetails>();
       ticketDetails= new LIST<Ticket__c>();
       ticketDetails=ticketDetails1;
       
       LIST<Payment__c> payments = new LIST<Payment__c>();
       BLN_Payment_DAO payDAO = new BLN_Payment_DAO();
       payments = payDAO.allpaymentsForEvent(selectedEvent);
       MAP<id,string> orderPayMap = new MAP<id,string>();
        for(Payment__c p:payments){
            orderPayMap.put(p.order__c,p.Registration_Type__c);
        }
        
         if(selectedFilterType== 'Attendee'){   
            string gname= '';
            string name='';
            string name1='';
            set<string> names = new set<string>();
            List<Ticket__c> tclist = new List<Ticket__c>();
            for(Ticket__c td:ticketDetails)
             {
                if((orderPayMap.get(td.order__c)==regtype && regtype != 'Registration Type') || (regtype == 'Registration Type')){
                gname=td.Tkt_profile__r.First_Name__c+td.Tkt_profile__r.Last_Name__c+td.Tkt_profile__r.Email__c;
                if(!names.contains(gname.tolowercase())){  
                     names.add(gname.tolowercase());
                     tclist.add(td);
                }
            }
            }

            for (Ticket__c tc :tclist){
                LIST<ticket__c> tlist = new LIST<ticket__c>();
                list<grouptics> grpticsList=new list<grouptics>();
                 for(Ticket__c td1:ticketDetails)
                 {
                     if((orderPayMap.get(td1.order__c)==regtype && regtype != 'Registration Type') || (regtype == 'Registration Type')){
                     grouptics grptics=new grouptics();
                     string n = tc.Tkt_profile__r.First_Name__c+tc.Tkt_profile__r.Last_Name__c+tc.Tkt_profile__r.Email__c;
                     name1 = td1.Tkt_profile__r.First_Name__c+td1.Tkt_profile__r.Last_Name__c+td1.Tkt_profile__r.Email__c;
                     if(n == name1)
                     {
                         list<tstatDetails> tstatDetLst=new list<tstatDetails>();
                         for(tstatus__c ts:td1.tstatus__r){
                                 if((scannedby!= '' && ts.owner.id==scannedby) || scannedby ==''){
                             tstatDetails tstatDet=new tstatDetails();
                             
                             BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
                             tz.tZone=td1.Event__r.Time_Zone__c;
                             tz.format='MM/dd/yyyy hh:mm a';
                           //  tz.dateTimeValue=ts.LastModifiedDate;
                             tz.dateTimeValue=ts.scan_time__c;
                             if(ts.scan_time__c != null){
                             tstatDet.lastmoddate=tz.getTimeZoneValue();
                             }else{
                             tstatDet.lastmoddate=null;
                             }
                             tstatDet.device=ts.Device_Name__c;
                             tstatDet.scanBy=ts.Owner.Name;
                                 tstatDet.tstatName = ts.Tstatus_name__c;
                             if(tstatDet != null)
                             tstatDetLst.add(tstatDet);
                         }
                             }
                             if(tstatDetLst.size() != 0){
                         grptics.tstatDetailsList = tstatDetLst;
                         grptics.tic=td1;
                     }
                         }
                         if(grptics.tstatDetailsList != null && grptics.tic != null)
                     grpticsList.add(grptics);
                   }
                   }
                 if(grpticsList.size()>0)
                 ticClas.add(new BLN_CheckInHistoryDetails(tc, grpticsList));
             }
      }
      else if(selectedFilterType== 'Ticket'){
          
          string ticname='';
          string tname1='';
            set<string> ticnames = new set<string>();
            List<Ticket__c> tclist1 = new List<Ticket__c>();
             for(Ticket__c tds:ticketDetails)
             {
                if((orderPayMap.get(tds.order__c)==regtype && regtype != 'Registration Type') || (regtype == 'Registration Type')){
                ticname=tds.Item_Pool__r.Item_Pool_Name__c;
                if(!ticnames.contains(ticname)){  
                 ticnames .add(ticname);
                 tclist1.add(tds);
               }
            }
            }
      
          for (Ticket__c tc :tclist1){
                LIST<ticket__c> tlist1 = new LIST<ticket__c>();
                list<grouptics> grpticsList=new list<grouptics>();
                 for(Ticket__c tds1:ticketDetails)
                 {
                     if((orderPayMap.get(tds1.order__c)==regtype && regtype != 'Registration Type') || (regtype == 'Registration Type')){
                     grouptics grptics=new grouptics();
                     string tn = tc.Item_Pool__r.Item_Pool_Name__c;
                     tname1 = tds1.Item_Pool__r.Item_Pool_Name__c;
                     system.debug('n1-----'+tn+'----n2----'+tname1);
                     if(tn == tname1)
                     {
                         list<tstatDetails> tstatDetLst=new list<tstatDetails>();
                         for(tstatus__c ts:tds1.tstatus__r){
                                 if((scannedby!= '' && ts.owner.id==scannedby) || scannedby ==''){
                             tstatDetails tstatDet=new tstatDetails();
                             
                             BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
                             tz.tZone=tds1.Event__r.Time_Zone__c;
                             tz.format='MM/dd/yyyy hh:mm a';
                           //  tz.dateTimeValue=ts.LastModifiedDate;
                             tz.dateTimeValue=ts.scan_time__c;
                             if(ts.scan_time__c != null){
                             tstatDet.lastmoddate=tz.getTimeZoneValue();
                             }else{
                             tstatDet.lastmoddate=null;
                             }
                             tstatDet.device=ts.Device_Name__c;
                             tstatDet.scanBy=ts.Owner.Name;
                                 tstatDet.tstatName = ts.Tstatus_name__c;
                             if(tstatDet != null)
                             tstatDetLst.add(tstatDet);
                         }
                             }
                             if(tstatDetLst.size() > 0){
                         grptics.tstatDetailsList = tstatDetLst;
                         grptics.tic=tds1;
                     }
                         }
                     if(grptics.tstatDetailsList != null || grptics.tic != null)
                     grpticsList.add(grptics);
                   }
                   }
                 if(grpticsList.size()>0)
                 ticClas.add(new BLN_CheckInHistoryDetails(tc, grpticsList));
             }
        }

        return ticClas;    
    }
    
    public class BLN_CheckInHistoryDetails {
       public Ticket__c GuestName{get;set;}
       public list<grouptics> tcinn{get;set;}

       // Constructor Loads the chekin checkout details for each ticket  for the given guest.
       public BLN_CheckInHistoryDetails(Ticket__c GuestName1,list<grouptics> groupticsList){
          GuestName=GuestName1;
          tcinn=groupticsList;

          }
    }
    
    public class grouptics{
        public Ticket__c tic{get;set;}
        public list<tstatDetails> tstatDetailsList{get;set;}
    }
    
    public class tstatDetails{
        public string lastmoddate{get;set;}
        public string device{get;set;}
        public string scanBy{get;set;}
        public boolean tstatName{get;set;}
    }
    
    
}