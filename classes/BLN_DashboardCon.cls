public with sharing class BLN_DashboardCon {
/***************************************************************
    *   Controller Name         : BLN_Dashboards
    *   Date                    : 30/10/2014 
    *   Author                  : Mythily Nagandla(mythilyn@globalnest.com)
    *   Purpose                 : This class is for Creating Dashboards.
******************************************************************/

    public BLN_UtillDisplayLinks   myticket { get; set; }
    public boolean isEventAdmin{get;set;}
    public boolean isBoothadmin{get;set;}
    public string selectedEventId{get;set;}
    public string eventCountry{get;set;}
    Public String currencySymbol{get;set;}
    public BLN_RegDashBoardInfo ALL_staticstics;
    
    //Using Common Queries used in various pages, By thirupathi
    //public transient LIST<BLN_Attendees_BAL.inncls> getTickets{get;set;}
    //public transient BLN_Attendees_BAL attBal{get;set;}
    public LIST<BLN_Item__c> tics1{get;set;}
    public BLN_Item_DAO bid{get;set;}
    
    //for lead retrival dashboard
    public BLN_LeadScan_DAO lsDAO{get;set;}
    public BLN_Device_Usage_DAO deviceusage{get;set;}
    public Device_Usage__c device{get;set;}
    public list<Lead_Scan__c> leadlist{get;set;}
    public list<device_usage__c> devicelist{get;set;}
    public integer iOScount{get;set;}
    public integer Androidcount{get;set;}
    public BLN_Ticket_DAO ticDAO{get;set;}
    public BLN_Ticket_DAO ticDAO1{get;set;}
    public list<ticket__c> ticTemp{get;set;}
    public transient list<leadratinginner> leadRating{get; set;}
    public list<boothreportInner> boothreport{get;set;}
    public string na{get;set;}
    
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
    
 //FOR SETTING PAGE DESIGN (SIDE BAR) USING COMPONENT   
    
//CONSTRUCTOR
    public BLN_DashboardCon(){
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
    myticket.isDashboardPage='active';
    myticket.isEventAdmin= true;
    myticket.tablabel='Dashboard';
    myticket.eventId=selectedEventId;
    
    try{
    myticket.eventName=se.NAme;
    }catch(exception e){}
    myticket.userPermissions(userInfo.getUserId(),selectedEventId);
        EAbool=false;
        
     id id1 = userinfo.getProfileId();
     system.debug('ProfileId'+id1);
     profile p1=[select Name from profile where id = :id1];
     //UC_Role__c p1=[select RoleId__r.Name from UC_Role__c  where GN_User__r.User__c=:userInfo.getUserId()];
     
     //if(p1.RoleId__r.Name == 'Event Admin')
     //BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
     //BLN_Event__c  se = new BLN_Event__c  ();
    if(se.Organizer_Email__c ==userInfo.getUserName()||se.OwnerId==userinfo.getuserid()) 
         EAbool=true;
    ALL_staticstics = new BLN_RegDashBoardInfo(selectedEventId);
    
    //getTickets= new LIST<BLN_Attendees_BAL.inncls>();
    //attBal = new BLN_Attendees_BAL();
    //getTickets =  attBal.getAllTickets(userInfo.getUserid(),selectedEventId);
     attendeesreig =0;
    attendeesreig =  ALL_staticstics.totalAttendee;
    //Total Tickets
    totalticsNo =0;
   
    totalticsNo =  ALL_staticstics.totalTickets;
    soldtics = 0;
   soldtics =  ALL_staticstics.totalSoldTickets;
    registeredatt = 0;
    generated = 0;
    //string status1 ='Cancelled';
    //string status_a ='Abandoned';
    //string status_n ='Not Paid';
   // string ststus2 = 'Completed';
    //string whereCondition = ' where Events__c = \''+selectedEventId+'\' '+' and  Order_Status__c != \''+status1+'\''+' and  Order_Status__c != \''+status_a+'\''+' and  Order_Status__c != \''+status_n+'\' ';
    //BLN_Order_DAO bod=new BLN_Order_DAO();
    //LIST<Order__c> ords = bod.orderQuery(whereCondition);  
     registeredatt =ALL_staticstics.totalcompOrders;
      generated = ALL_staticstics.totalrevenue;
         generated  = generated.setScale(2,RoundingMode.HALF_UP);
         
    }
    catch(exception ex){}
    

    }  
    
    public Pagereference restoftheQueries()
    {
    try{
    getpaymentwithType();
    getpaymentwithtickettype();
    expectedrevenue();
    TotalTics();
    
      }catch(exception ex){}
      return null; 
    }   
    
  //CONSTRUCTOR for Webservice
    public BLN_DashboardCon(string Eventid){
    try{
            selectedEventId = Eventid;
       system.debug('----eventid-----'+Eventid);
        
     id id1 = userinfo.getProfileId();
     profile p1=[select Name from profile where id = :id1];
     
      system.debug('----profile-----'+p1);
        
     
        
    getpaymentwithType();
    getpaymentwithtickettype();
    expectedrevenue();
    TotalTics();
    
    //getTickets= new LIST<BLN_Attendees_BAL.inncls>();
    //attBal = new BLN_Attendees_BAL();
    //getTickets =  attBal.getAllTickets(userInfo.getUserid(),selectedEventId);
    
    //Attendees
    attendeesreig =0;
    attendeesreig =  ALL_staticstics.totalAttendee;
   /*  for(BLN_Attendees_BAL.inncls tcTemp :getTickets){
         if(tcTemp.ticket.Item_Type__r.Badgable__c != 'N - No Badge' || tcTemp.ticket.Item_Pool__r.Badgable__c != 'N - No Badge'){
             attendeesreig++;
         }
     }*/
     
    
    //Total Tickets
    totalticsNo =0;
    ALL_staticstics = new BLN_RegDashBoardInfo(selectedEventId);
    totalticsNo =  ALL_staticstics.totalTickets;
  /*  bid=new BLN_Item_DAO();
    tics1 = bid.getEventItems(selectedEventId);
     for(BLN_Item__c Item: tics1 ){
         totalticsNo = totalticsNo + Item.item_count__c;
     }*/
     
    registeredatt = 0;
    generated = 0;
    string status1 ='Cancelled';
   // string ststus2 = 'Completed';
    string status_a ='Abandoned';
    string status_n ='Not Paid';
    string whereCondition = ' where Events__c = \''+selectedEventId+'\' '+' and  Order_Status__c != \''+status1+'\''+' and  Order_Status__c != \''+status_a+'\''+' and  Order_Status__c != \''+status_n+'\' ';
    //BLN_Order_DAO bod=new BLN_Order_DAO();
    //LIST<Order__c> ords = bod.orderQuery(whereCondition);  
     // registeredatt = ords.size();
      registeredatt =ALL_staticstics.totalcompOrders;
        /* for(Order__c ord : ords){
             generated = generated + ord.Order_Total__c; 
         }*/
          generated = ALL_staticstics.totalrevenue;
         
         
        //for scanned leads
    lsDAO =new BLN_LeadScan_DAO();
    leadlist = lsDAO.getLeadScan_dashboard(selectedEventId,'');
    
    
    deviceusage= new BLN_Device_Usage_DAO();
    devicelist =  deviceusage.getDeviceUsage(selectedEventId);
    system.debug('devicelist '+devicelist);
    
    // for ios and android users
    iOScount = 0;
    Androidcount = 0;
    for(device_usage__c du:devicelist){
        if(du.Device_OS__c=='iOS'){
            iOScount++;
        }
        else if(du.Device_OS__c=='Android'){
            Androidcount++;
        }
    
    }
    
    //for boothleads users
    ticDAO= new BLN_Ticket_DAO();
    ticTemp=new list<ticket__c>(); 
    string s1='Lead Retrieval';
    BLN_Event__c eve=[select OwnerId,Organizer_Email__c from BLN_Event__c where id= :selectedEventId];
    string userid=userinfo.getuserid();
    string temp='';
    
    if(eve.Organizer_Email__c==UserInfo.getUserName()||eve.OwnerId==UserInfo.getuserid()){
    temp=' WHERE event__r.id = \''+selectedEventId+'\''+' AND Item_Pool__r.Item_Type__r.Name ='+'\''+s1+'\''+'AND Ticket_Status__c!=\'Cancelled\' AND Ticket_Status__c = \'Booked\'';
    }else{
    temp=' WHERE event__r.id = \''+selectedEventId+'\''+' AND Item_Pool__r.Item_Type__r.Name ='+'\''+s1+'\''+'AND Ticket_Status__c!=\'Cancelled\' AND Ticket_Status__c = \'Booked\' AND tkt_profile__r.BLN_GN_User__r.User__c = \''+userid+'\'';
    }
    
    ticTemp = ticDAO.userOrderAndTickets(temp);
    system.debug('aaaaaaaaaaaaaaaaaa'+ticDAO.userOrderAndTickets(temp));

    //for lead rating report
     leadRating= new LIST<leadratinginner>();
    
    for(integer i=0;i<=5;i++){
        integer leadcount=0;
        for(lead_scan__c l:leadlist){
            if(l.rating__c==null)
            l.rating__c=0;
            
            if(l.rating__c==i)
            leadcount++;
        }
       if(leadcount!=0)
       leadRating.add(new leadratinginner(i,leadcount));     
    } 
    
    //for Report by Booth Admin and Booth User Scans
      list<string> names = new list<string>();
       set<string> nameset = new set<string>();      
      for(lead_scan__c ls1:leadlist){
          if(!nameset.contains(ls1.Scanner_User__r.first_name__c+' '+ls1.Scanner_User__r.Last_name__c))
          names.add(ls1.Scanner_User__r.first_name__c+' '+ls1.Scanner_User__r.Last_name__c);
          nameset.add(ls1.Scanner_User__r.first_name__c+' '+ls1.Scanner_User__r.Last_name__c);
      }
      boothreport =new list<boothreportInner>();   
       for (Integer n = 0; n <= names.size()-1; n++)
       {
           integer lcnt=0;
           for(lead_scan__c ls1:leadlist){
               if(names[n]==ls1.Scanner_User__r.first_name__c+' '+ls1.Scanner_User__r.Last_name__c){
                   lcnt++;
               }
           }
           boothreport.add(new boothreportInner(names[n], lcnt));
       }       
      
             
      //for scan attendee dashboard
      Statistics();
      checkInStatus();

    Totalnoofcheckinsevent = 0;
       
             
       LIST<Ticket__c> ticketsList= new LIST<Ticket__c>();
          
            ticketsList= [SELECT Ticket_Status__c, Tstatus_Id__c, (select Tstatus_name__c from Tstatus__r order by lastmodifieddate DESC limit 1)
                            FROM Ticket__c 
                           WHERE Event__c =: selectedEventId
                             AND (Item_Type__r.Badgable__c !=: 'N - No Badge' OR Item_Pool__r.Badgable__c !=: 'N - No Badge')
                             AND Ticket_Status__c =: 'Booked' AND TStatus_Id__c!=Null];     
                             
          
            for(Ticket__c tt : ticketsList){
                  
                 if( tt.Tstatus_id__r.Tstatus_name__c ==true){
                   Totalnoofcheckinsevent++; 
                 } 
                 
             }
             }catch(exception ex){}
    }    
    
    
    
//TO GET DATA FOR MAKING OF PAYMENTS Vs PAYMENT TYPE DASHBOARD
    public transient LIST<paymentinner> payinn {get ; set ;}
    public decimal payedamount {get ; set ;}
    public String cur {get ; set ;}
    public string paytype {get ; set ;}    
    public LIST<paymentinner> getpaymentwithType(){
    /***********************For currency symbol*********************************/
     BLN_PromoCode_BAL blneventdetail_bl = New BLN_PromoCode_BAL();
        BLN_Event__c  seventdet = new BLN_Event__c  ();
        seventdet = blneventdetail_bl.eventdetails(selectedEventId );
        eventCountry = seventdet.BLN_Country__r.Short_Name__c;
      currencySymbol = seventdet.BLN_Country__r.Currency__r.Currency_Symbol__c;
        system.debug('@@@sg'+currencySymbol  );
     
    
    /*********************************************************/
    system.debug('eeeeeeeeeeeeeeeeeeeeee'+selectedEventId);
    payinn = new LIST<paymentinner> ();
   //system.debug('------------All Staticstrics Value--------------'+ALL_staticstics.innRevList);
   list<BLN_RegDashBoardInfo.InnForPgateways>   paytypewisetot = ALL_staticstics.innRevList;
   for(BLN_RegDashBoardInfo.InnForPgateways pts:paytypewisetot ){
                 payedamount =pts.revenue;
           cur=currencySymbol;
         
          if(pts.paygatey != null){
           paytype=pts.paygatey+'('+currencySymbol+')';
           }else{
            paytype='Free'+'('+currencySymbol+')';
           }
           if(payedamount !=0){
           payinn.add(new paymentinner(paytype,payedamount,cur));
           }
           system.debug('::::::::::::::PAY INNER:::::::::::::;'+payinn);

            }
  /*  AggregateResult[] paymentsresult = [SELECT Payment_Mode__c p,SUM(Order__r.Order_Total__c) s FROM Payment__c WHERE Order__r.Events__c =:selectedEventId AND Order__r.Transaction_Status__c =: 'Completed' AND Order__r.Order_Status__c != 'Cancelled'  GROUP BY Payment_Mode__c];
    system.debug('aaaaaaaaaaaaaaaaaaaaaaaaaaaa'+paymentsresult );
        for(AggregateResult pay : paymentsresult)     
          {
           payedamount =(decimal)pay.get('s');//+decimal.valueOf('$')
           cur=currencySymbol;
          system.debug('@@currencySymbol'+currencySymbol);
          if((String)pay.get('p') != null){
           paytype=(String)pay.get('p')+'('+currencySymbol+')';
           }else{
            paytype='Free'+'('+currencySymbol+')';
           }
           if(payedamount !=0){
           payinn.add(new paymentinner(paytype,payedamount,cur));
           }
           system.debug('::::::::::::::PAY INNER:::::::::::::;'+payinn);
          } */
      return payinn;
    }
//INNER CLASS FOR PAYMENT Vs PAYMENT TYPE REPORT 
    public class paymentinner
{
     public decimal amount{get;set;} 
     public String paytype{get;set;}
     public String dollar{get;set;}
     public string ptypendamt{get;set;} 
     public paymentinner(String paytype, decimal amount, String dollar)  
     { 
         this.amount=amount;
         this.paytype= paytype;  
         this.dollar= dollar; 
         this.ptypendamt=paytype+' '+amount;   
     }
}
//TO GET DATA FOR MAKING OF PAYMENTS Vs TICKET TYPE DASHBOARD
    public transient LIST<ticetpaymentinner> ticpayinn {get ; set ;}
    public decimal payment {get ; set ;}
    public string tictype {get ; set ;}
    public integer registeredatt {get ; set ;}
    public LIST<ticetpaymentinner> getpaymentwithtickettype(){
   
    ticpayinn = new LIST<ticetpaymentinner> ();
    list<BLN_RegDashBoardInfo.InnForItemPrice>  allticto_t_amt =  ALL_staticstics.ItemRevList;
         
        for(BLN_RegDashBoardInfo.InnForItemPrice ite:allticto_t_amt){
       if(ite.itrevenue != null){
        string  tictype = '';
      
        payment = ite.itrevenue;
       
         tictype = ite.item.item_name__c;
        tictype=(tictype.length()>15) ? tictype.subString(0,15) : tictype;
         ticpayinn.add(new ticetpaymentinner(tictype ,payment ));
         }
        }
 /*  
    //AggregateResult[] paywithtics = [SELECT count(id) c,SUM(Order__r.Order_Total__c) s,Item__r.item_name__c t FROM Order_Item__c WHERE  Item__r.Event__c =: selectedEventId AND Order__r.Transaction_Status__c =: 'Completed' AND Order__r.Order_Status__c != 'Cancelled' GROUP BY Item__r.item_name__c,Item__c ];//WHERE  Item__r.Event__c =: selectedEventId
    AggregateResult[] paywithtics = [SELECT count(id) c,sum(Item_Total__c) s,sum(Item_Fee__c) x,sum(Item_Discount__c) dis,Item__r.item_name__c t FROM Order_Item__c WHERE Order__r.Events__c =:selectedEventId  AND Item__r.Event__c =: selectedEventId AND Order__r.Transaction_Status__c =: 'Completed' And Order__r.Order_Status__c =: 'Fully Paid'  GROUP BY Item__r.item_name__c,Item__c ];
    
    //LIST<BLN_Item__c> items = [SELECT id,Name,item_type__r.Name,item_name__c,price__c,item_count__c FROM BLN_Item__c WHERE Event__c =: selectedEventId ];
    //MAP<string,items > itemmap = new MAP<string,items> ();
    system.debug('ttttttttttttttttttttttt'+paywithtics);
    ticpayinn = new LIST<ticetpaymentinner> ();
         SET<ID> BLID = new SET<ID> ();
        for(AggregateResult ag :paywithtics){
           //for(BLN_Item__c ITMS : items ){
                payment =(decimal)ag.get('s')+(decimal)ag.get('x')-(decimal)ag.get('dis');
                tictype =(String)ag.get('t');
                tictype=(tictype.length()>15) ? tictype.subString(0,15) : tictype;
                
                    //if(tictype == ITMS.item_name__c){
                        //if(BLID.add(ITMS.id)){
                        ticpayinn.add(new ticetpaymentinner(tictype ,payment ));
                        system.debug('::::::::::::::PAY INNER:::::::::::::;'+payinn);
                    //}else{
                     //if(BLID.add(ITMS.id)){
                       // payment = 0;
                       // ticpayinn.add(new ticetpaymentinner(tictype ,payment ));}
                    //}
            //}
           //} 
        } */
        return ticpayinn;
    
    }
//INNER CLASS FOR PAYMENT Vs TICKET TYPE REPORT 
    public class ticetpaymentinner{
    public string tictype {get ; set ;}
    public decimal payment {get ; set ;}
        public ticetpaymentinner(string tictype , decimal payment){
            this.tictype = tictype;
            this.payment = payment;
    
        }
    }
//TO GET DATA FOR MAKING OF Expected Revenue Vs Generated Revenue DASHBOARD
    public decimal expected {get ; set ;}
    public decimal generated {get ; set ;}
    public transient LIST<revenueinn> exinner {get ; set ;}
    public string rtype {get ; set ;}
    public decimal revenuepercent1 {get ; set ;}
    public void expectedrevenue(){
    revenuepercent1 =0;
    expected = 0;
    generated=0;
    rtype ='';
    exinner = new LIST<revenueinn> (); 
    bid=new BLN_Item_DAO();
    tics1 = bid.getEventItems(selectedEventId);
    MAP<string,decimal> itemsmap = new MAP<string,decimal> ();
    MAP<string,decimal> itemsmapcount = new MAP<string,decimal> ();
    /******************************/
    Map<id,Decimal> Evefeepricemap =new Map<id,Decimal>();
    list<Event_Price__c> evefeeprice = [select id,Item_type__c,Item_type__r.NAME,BL_Fee_Amount__c from Event_Price__c  where Event__c =:selectedEventId  AND Active_Flag__c = TRUE];
      Decimal eprice=0;
        for(Event_Price__c  eveprice:evefeeprice ){
       IF( eveprice.Item_type__r.NAME == 'Admissions'){
         eprice =  eveprice.BL_Fee_Amount__c ;
        }
       }
   
    for(Event_Price__c  ep:evefeeprice ){
             IF( ep.Item_type__r.NAME == 'Lead Retrieval' || ep.Item_type__r.NAME == 'MatchLeads Buyer' || ep.Item_type__r.NAME == 'MatchLeads Seller'  ){
                     ep.BL_Fee_Amount__c = eprice;
                      }
        Evefeepricemap.put(ep.Item_type__c,ep.BL_Fee_Amount__c );
    }
    
    system.debug('##'+tics1.size());
    
    /***************************/
        for(BLN_Item__c its : tics1){
        decimal taxamt  = 0;
            if(its.price__c == 0 || its.service_fee__c =='Include the Eventdex fee in to the total ticket price'){
            taxamt = 0;
            }else{
           //taxamt = its.Item_Type__r.BL_Fee_Amt_per_res__c * its.item_count__c ;
                   if(its.Item_Type__r.Name == 'Package'){
                         taxamt = 0;
                        Decimal FeeAmount = 0.0;                                   
                        LIST<String> IPStrings = new LIST<String>();  
                        IPStrings.add(its.Item_Pool__r.Id);
                        BLN_ItemPool_DAO ItemPoolDAO = new BLN_ItemPool_DAO();
                        LIST<Item_Pool__c> IPList = ItemPoolDAO.getPackageItemPools(IPStrings);
                        //system.debug('##'+IPList.size());
                        string   PackageInfo ='';
                    for(Item_Pool__c IP: IPList){
                        if(IP.Item_Type__r.BL_Fee_Amt_per_res__c!= NULL){
                               // system.debug('%%'+Evefeepricemap.get(IP.Item_Type__c));
                                  if(Evefeepricemap.get(IP.Item_Type__c) !=null){
                                       // system.debug('Fee Amount For Item Type:'+ (IP.Item_Count__c * Evefeepricemap.get(IP.Item_Type__c)));
                                         FeeAmount += IP.Item_Count__c * Evefeepricemap.get(IP.Item_Type__c);
                                       }
                          }                       
                        }
                    taxamt = FeeAmount;     
                    System.debug('$$$'+taxamt );            
                   }else{
                   taxamt = Evefeepricemap.get(its.item_type__c) * its.item_count__c;
                   }
            }
            system.debug('%%%%%%%%%'+((its.price__c * its.item_count__c)+ taxamt) );
            expected = expected + (its.price__c * its.item_count__c)+ taxamt ;
            system.debug('::::::::::::;;;ex:::::::::;'+expected);
            itemsmap.put(its.id,its.price__c );
            itemsmapcount.put (its.id,its.item_count__c);
        }
        system.debug('::::::::::::;;;ex:::::::::;'+expected);
  //  AggregateResult[] tics = [SELECT count(id) c,Item__r.id i FROM Ticket__c WHERE Ticket_Status__c =: 'Booked' AND Item__r.Event__c =: selectedEventId AND   Order__r.Transaction_Status__c =: 'Completed' AND Order__r.Order_Status__c != 'Cancelled' GROUP BY Item__r.id];
  // AggregateResult[] tics =  [SELECT count(id) cd,sum(Item_Total__c) sd,sum(Item_Fee__c) xd FROM Order_Item__c WHERE Order__r.Events__c =:selectedEventId  AND Item__r.Event__c =: selectedEventId AND Order__r.Transaction_Status__c =: 'Completed' And Order__r.Order_Status__c =: 'Fully Paid' GROUP BY Item__r.item_name__c,Item__c ];
  //  BLN_Payment_DAO ordpay=new BLN_Payment_DAO();
 //  AggregateResult[] tics =  ordpay.paymentsForEvent(selectedEventId);
    //    for(AggregateResult ag : tics ){
           // integer payment =(integer)ag.get('c');
           // system.debug('::::::::::::;;;ge:::::::::;p'+payment );
        //    string itemtype =(String)ag.get('i');
           // system.debug('::::::::::::;;;ge:::::::::;'+itemtype );
           //   system.debug('::::::::::::;;;ge:::::::::;'+itemsmap.get((String)ag.get('i')));
             //  system.debug('::::::::::::;;;ge:::::::::;'+(integer)ag.get('c'));
        //   generated = generated+(itemsmap.get((String)ag.get('i')));// * (integer)ag.get('c'));//
           // system.debug('::::::::::::;;;ge:::::::::;'+generated );
          // generated = generated + (Decimal)ag.get('sd')+ (Decimal)ag.get('xd');
      //     generated = generated + (Decimal)ag.get('amt');
          
     //   }
          
      generated = ALL_staticstics.totalrevenue;
        LIST<string> types = new LIST<string> ();
      //  system.debug('@@abc'+'Expected Revenue('+currencySymbol+')');
        string exr='Expected Revenue('+currencySymbol+')';
        string Gnr= 'Generated Revenue('+currencySymbol+')';
        types.add(exr);
        types.add(Gnr);
            for(string s: types){
            rtype ='';
             rtype =s;
                If(rtype  == exr ){
                    if(expected !=0){
                     exinner.add(new revenueinn(rtype  , expected ));
                     }
                     }
                 else{
                     if(generated !=0){
                     exinner.add(new revenueinn(rtype  , generated ));
                     }
                     }
              system.debug(':::::::::::::::;;rtype ::::::::::::::;'+exinner);       
        }
        if(expected != 0){
            //revenuepercent1 = Math.MOD(integer.valueOf(generated),integer.valueOf(expected)) * 100;
            system.debug('eeeeeeeeee'+expected);
            system.debug('rrrrrrrrrr'+revenuepercent1 );
            system.debug('eeeeeeeeee'+generated);
            system.debug('rrrrrrrrrr'+expected);
            system.debug('gggggggggggg'+generated);
            system.debug('gggggggggggg'+integer.valueOf(math.abs(generated)));
            Decimal i = generated;//integer.valueOf(math.abs(generated));
            Decimal j = expected;//integer.valueOf(math.abs(expected));
             system.debug('%%%%%%%%%%%%'+i / j);
             system.debug('iiiiiiiiiiiiii'+i);
            system.debug('jjjjjjjjjjjj'+j);
            revenuepercent1 = (decimal)((i* 100) / j);
             revenuepercent1 = revenuepercent1.setScale(2,RoundingMode.HALF_UP);
        }
    }
//INNER CLASS FOR PAYMENT Vs PAYMENT TYPE REPORT 
    public class revenueinn
    {
     public String type {get;set;} 
     public decimal geamount{get;set;} 
     public string endgrev{get;set;}
     public revenueinn(String  type , decimal geamount)  
     { 
         this.type = type ;
         this.geamount= geamount;    
          this.endgrev = type+' '+geamount;  
     }
    }

    //TO GET DATA FOR MAKING OF TOTAL NO OF TICKETS Vs SOLD TICKETS  DASHBOARD 
    public transient LIST<soldticketsinn> soldinn {get ; set ;}  
    public decimal booked {get ; set ;}
    public decimal Available {get ; set ;}
    public decimal totalticsNo {get ; set ;}
    public decimal soldtics {get ; set ;}
    public decimal attendeesreig {get ; set ;}
    public decimal Totalnoofcheckinsevent{get;set;}
    
    public void TotalTics(){
       // soldtics =0;
        //attendeesreig =0;
        soldinn  = new LIST<soldticketsinn> ();
    list<BLN_RegDashBoardInfo.InnForItemPrice>  alltictotandavbt =  ALL_staticstics.ItemRevList;
         
        for(BLN_RegDashBoardInfo.InnForItemPrice ite:alltictotandavbt ){
       if(ite.item.item_count__c !=null){
           
        booked =0;
        available = 0;
        string  typename = '';
        booked =  ite.ItemQuantity ;
        system.debug('####'+ite);
            if(ite.ItemQuantity == null){
               booked =0;
               }
       
         available = ite.item.Available_Tickets__c;
         typename = ite.item.item_name__c;
         typename=(typename.length()>15) ? typename.subString(0,15) : typename;
         soldinn.add(new soldticketsinn(booked,available,typename,ite.cancelledqty));
         }
        }
    
   /* 
        bid=new BLN_Item_DAO();
        tics1 = bid.getEventItems(selectedEventId);
        MAP<string,decimal> itemsmapcount = new MAP<string,decimal> ();
        for(BLN_Item__c its : tics1){        
            itemsmapcount.put (its.id,its.item_count__c);
        }
        system.debug('::::::::::::;;;ex:::::::::;'+expected); 
        
         //system.debug('########:'+tics.size());
         booked =0;
         available = 0;
         for(BLN_Item__c item : tics1){
         booked =0;
         available = 0;
         
            getTickets= new LIST<BLN_Attendees_BAL.inncls>();
            attBal = new BLN_Attendees_BAL();
            getTickets =  attBal.getAllTickets(userInfo.getUserid(),selectedEventId);
             
             for(BLN_Attendees_BAL.inncls tt : getTickets){
                 if((tt.ticket.Item__r.id == item.id && tt.ticket.Ticket_Status__c == 'Booked' && (tt.ticket.Item_Type__r.Name != 'Package' || tt.ticket.Item_Pool__r.Item_Type__r.Name == 'Package'))){
                    booked ++; 
         
                 }else if(tt.ticket.Item__r.id == item.id && tt.ticket.Ticket_Status__c != 'Booked' ){
                     //available ++;
                 }        
             }
                 
             available = available + (item.item_count__c - booked);
             string typename = item.item_name__c;
             typename=(typename.length()>15) ? typename.subString(0,15) : typename;
             soldinn.add(new soldticketsinn(booked,available,typename));
             // soldtics= soldtics+booked;   
             } */
     }
 
    
//INNER CLASS FOR TOTAL NO OF TICKETS Vs SOLD TICKETS REPORT 
    public class soldticketsinn {
        public String TIC {get;set;} 
        public decimal Sold{get;set;} 
        public decimal Available{get;set;} 
        public decimal Cancelled{get;set;} 
        public soldticketsinn(decimal Sold,decimal Available,String TIC,decimal Cancelled)  { 
            this.Sold=Sold;
            this.Available=Available;
            this.TIC=TIC;
            this.Cancelled=Cancelled;
        }
    }
    
    //for Report by Booth Admin and Booth User Scans dashboard graph
    public with sharing class boothreportInner{
    public string BLusers{get;set;}
    public string ScanNo{get;set;}
        public boothreportInner(string BLusers, integer ScanNo){
            this.BLusers= BLusers;
            this.ScanNo= string.valueof(ScanNo);
    
        }
    }
    
    //for lead rating dashboard graph
    public with sharing class leadratinginner{
    public string leadrat{get;set;}
    public integer leadNo{get;set;}
        public leadratinginner(integer leadrat, integer leadNo){
            this.leadrat= string.valueof(leadrat);
            this.leadNo= leadNo;
    
        }
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
           if(!em.contains(ts.Ticket__r.TKT_Profile__r.Email__c)){
               em.add(ts.Ticket__r.TKT_Profile__r.Email__c);
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
                 AND Event__c =: selectedEventId and item_pool__c in:poolids];
         }
        else
        //
    tcs= [select Item_Pool__r.Item_Pool_Name__c,tstatus_id__c,tstatus_id__r.Tstatus_name__c,TKT_Profile__r.Email__c,(SELECT Tstatus_name__c from tstatus__r order by lastmodifieddate) from ticket__c 
               where Ticket_Status__c != 'Cancelled'
                 AND Ticket_Status__c = 'BOOKED'
                 AND Event__c =: selectedEventId];
                 }
                 else
                 tcs= [select Item_Pool__r.Item_Pool_Name__c,tstatus_id__c,tstatus_id__r.Tstatus_name__c,TKT_Profile__r.Email__c,(SELECT Tstatus_name__c from tstatus__r order by lastmodifieddate) from ticket__c 
               where Ticket_Status__c != 'Cancelled'
                 AND Ticket_Status__c = 'BOOKED'
                 AND Event__c =: selectedEventId];
                 
                 
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
                if(t==tic.Item_Pool__r.Item_Pool_Name__c && tic.tstatus_id__c != null){
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
    
        /*CheckInStatusList= new LIST<AggregateResult>();
        CheckInStatusList= [SELECT COUNT(ID) c,Ticket__c, Ticket__r.Item__r.Item_Name__c tic, Tstatus_name__c status, Ticket__r.Client_GN_User__r.Email__c em
                            FROM Tstatus__c
                            WHERE Ticket__r.Event__c =: selectedEventId AND (Ticket__r.Tstatus_Id__c != NULL)
                            AND Ticket__r.Ticket_Status__c != 'Cancelled' 
                            GROUP BY Ticket__c,Ticket__r.Client_GN_User__r.Email__c,Tstatus_name__c,Ticket__r.Item__r.Item_Name__c];
        
        system.debug(CheckInStatusList.size()+' CHECK INS LIST '+CheckInStatusList);
        CheckInInnerList= new LIST<CheckInInner>();
        
        MAP<String, Integer> CheckInMAP= new MAP<String, Integer>();
        MAP<String, Integer> NotCheckInMAP= new MAP<String, Integer>(); 
        SET<String> TicketsSET= new SET<String>(); 
        set<string> mailid= new set<string>();
             
        for(AggregateResult agg: CheckInStatusList){
            TicketsSET.add((String)agg.get('tic'));
            system.debug(agg.get('tic')+' TICKET NAME '+agg.get('status')+'   '+agg.get('c')+'      '+agg.get('em'));
            if(!mailid.contains((string)agg.get('em'))){
                mailid.add((string)agg.get('em'));
                
           } 
        
        
        if(agg.get('status') == TRUE){
                CheckInMAP.put((String)agg.get('tic'), (Integer)agg.get('c'));
            }else if(agg.get('status') == FALSE){
                NotCheckInMAP.put((String)agg.get('tic'), (Integer)agg.get('c'));
            }
        }
        for(String ticket: TicketsSET){
            Integer checkIn= 0;
            Integer notCheckIn= 0;
            if(CheckInMAP.get(ticket) != NULL){
                checkIn= CheckInMAP.get(ticket);
            }
            if(NotCheckInMAP.get(ticket) != NULL){
                notCheckIn= NotCheckInMAP.get(ticket);
            }
            

            if(checkIn != 0 || notCheckIn != 0){

                if(ticket.length() >15){
                    ticket= ticket.substring(0,14)+' ...';
                }
                CheckInInnerList.add(new CheckInInner(ticket, checkIn, notCheckIn));
            }
        }
    
        system.debug(CheckInInnerList.size()+' CHECK IN INNER '+CheckInInnerList);*/
        
        
    
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