@RestResource(urlMapping='/BLN_ASC_Checkin/*')

global class BLN_ASC_Checkin{


global static BLN_Mytickets_BAL ordersList {get ; set ;}
 global static DateTime moddate{get; set ;}
 global static TotalList  TL {get ; set ;}
 
  @HttpPost  
    global static TotalList doPost(){ 
    //itemsDao = new BLN_Item_DAO ();
    RestRequest req = RestContext.request;
   List<maincontainer> Mc = new List<maincontainer> ();
   TL = new TotalList ();
   //ord = new Ordersonly ();   
    string eventid = req.params.get('Event_id');
    string Userid = req.params.get('User_id');    
    string requestedDate = req.params.get('LastModifiedDate');
    //system.debug('requestedDate === '+requestedDate );
    DateTime LastmodiFieddateFromMobile;
    if(requestedDate != '' && requestedDate != null){
    LastmodiFieddateFromMobile  = dateTime.valueofGmt(requestedDate);
    //system.debug('LastmodiFieddateFromMobile============================'+LastmodiFieddateFromMobile);
   
    Date currDate = LastmodiFieddateFromMobile.date();
    Time currTime = LastmodiFieddateFromMobile.time();
  LastmodiFieddateFromMobile = datetime.newinstance(currDate,currTime);   
  }
    
    String siteurl1=Label.SiteURL;
    string orgid = UserInfo.getOrganizationId();
    
    boolean Seminarsflag=false;
    boolean Exhibitorflag=false;
    boolean Sponsorsflag=false;
    boolean Speakersflag=false;
    BLN_Reg_Settings_DAO regDAO;
    
        BLN_app_settings_BAL appcon=new BLN_app_settings_BAL();
        appcon.checkticdetails(EventID);
        Seminarsflag= appcon.Seminarsflag;
        Exhibitorflag= appcon.Exhibitorflag;
        Sponsorsflag= appcon.Sponsorsflag;
        Speakersflag= appcon.Speakersflag;
       
         regDAO = new BLN_Reg_Settings_DAO();
         List<Reg_Setting__c> Reg=  regDAO.getregsetlist(eventid);
          
        ordersList = new BLN_Mytickets_BAL();
        if(moddate!=null)
        ordersList.moddate=moddate;
        Map<id,string> mapdemo  = new Map<id,string>();
        //system.debug('@@chekineventid'+eventid);
        //system.debug('@@chekinuserid'+Userid);
       LIST<BLN_Mytickets_BAL.inncls>  inlists = ordersList.userTickets(Userid,eventid,'Bln_orders','');
       
     Boolean checknull = false;   
    for(BLN_Mytickets_BAL.inncls cls : inlists){
    
             maincontainer nemain= new maincontainer();
            
            if(cls.orderInn.lastmodifieddate > LastmodiFieddateFromMobile)
            if(cls.orderInn!= null)
                  nemain.orderInn = cls.orderInn; 
                  
           if(cls.orderInn.lastmodifieddate > LastmodiFieddateFromMobile)
           nemain.dt=cls.dt;
            
            List<ticket__c> tliist=new List<Ticket__c>();
            for(ticket__c t : cls.ticketsInn){
                if(t.lastmodifieddate > LastmodiFieddateFromMobile)
                tliist.add(t);
               
            }
             if(tliist.size()>0)
             nemain.ticketsInn = tliist;
             
                if(cls.paymentInn.lastmodifieddate > LastmodiFieddateFromMobile)
                  nemain.paymentInn = cls.paymentInn;       
            
            List<ticket__c> tliist1=new List<Ticket__c>();
             for(ticket__c t : cls.cancelledTickets){
                if(t.lastmodifieddate > LastmodiFieddateFromMobile)
               tliist1.add(t);
            }
            if(tliist1.size()>0)
            nemain.cancelledTickets=tliist1;//=cls.cancelledTickets;
            
            List<order_Item__c > orditemlist=new List<order_Item__c >();
            for(order_Item__c t : cls.orderItemInn){
                if(t.lastmodifieddate > LastmodiFieddateFromMobile)
                orditemlist.add(t);                
            }
             if(orditemlist.size()>0)
            nemain.orderItemInn = orditemlist; 
           
           if(cls.orderInn.lastmodifieddate > LastmodiFieddateFromMobile && cls.orderInn!= null)
           nemain.orderPrice= cls.orderPrice; 
            
            List<Company__c> companylist=new List<Company__c>();
            for(Company__c t : cls.compListInner){
                if(t.lastmodifieddate > LastmodiFieddateFromMobile)  
                companylist.add(t);             
            }
              if(companylist.size()>0)          
            nemain.compListInner = companylist;
            
          List<Hash_Tag__c> taglist=new List<Hash_Tag__c >();
           /* for(Hash_Tag__c t : cls.ticketTags){ // kept in comments to save hep Size
                if(t.lastmodifieddate > LastmodiFieddateFromMobile)
              taglist.add(t); 
           }*/
           if(taglist.size()>0)  
           nemain.ticketTags = taglist;
          
        if(nemain.orderInn!=null || nemain.ticketsInn!=null || nemain.paymentInn!= null || nemain.cancelledTickets!=null || nemain.orderItemInn!=null || nemain.orderPrice!=null || nemain.compListInner!=null || nemain.ticketTags!=null)
         {
          Mc.add(nemain);
          checknull = true;
          }
    }
           if(checknull == true)
           TL.TotalLists= Mc;
    /**********************************************/     
    BLN_Booth_Map_DAO bmapDao=new BLN_Booth_Map_DAO();
        list<Booth_Map__c> bmaps_list= bmapDao.BoothDetailslist(eventid,LastmodiFieddateFromMobile);
    //System.debug('@@@@@3##'+bmaps_list);
    set<id> ticids=new set<id>();
    if(bmaps_list.size()>0){
    for(Booth_Map__c bm:bmaps_list){
    
    ticids.add(bm.Ticket_id__c);
    }
    }
   /***********************************************/ 
    BLN_ASC_MobileAppSettings bma = new BLN_ASC_MobileAppSettings();
  
    TL.MobileAppSettings =  BLN_ASC_MobileAppSettings.doPost(eventid,Userid);
    BLN_Ticket_DAO btd = new BLN_Ticket_DAO();
   LIST<Ticket__c> boothticks =NEW LIST<Ticket__c>();
      
     IF(requestedDate != '0000-00-00 00:00:00'){
     //system.debug('Entered$$');
     boothticks=  btd.eventBookedlistoftics(eventid,ticids);
     }
    if(LastmodiFieddateFromMobile==null){
    TL.Eventtickets = btd.eventBookedTickets(eventid);
    }else{
       
    TL.Eventtickets = btd.eventBookedTickets(eventid,LastmodiFieddateFromMobile);
    //system.debug('#####@@@@'+TL.Eventtickets);
     if(boothticks.size()>0){
      TL.Eventtickets.addALL(boothticks);
       }
    }
    set<id> trackList=new set<id>();
    //for getting Event boothdetails
     List<Container2> contain =new List<Container2>();
    LIST<booth_map__c> bMap=[select id,name,Booth_Area__c,Booth_Number__c,BLN_Room__r.Room_Number__c,BLN_Room__r.Name,Ticket_id__r.Name,Ticket_id__r.tkt_profile__r.Company_Logo__c,Ticket_id__r.tkt_profile__r.TKT_Company__c,Ticket_id__r.tkt_profile__c,Ticket_id__r.tkt_profile__r.BLN_Company__c from booth_map__c where Ticket_id__r.Event__c= : eventid];
        //system.debug('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'+bMap);
        if(bMap.size()>0 ){
         MAP<string,list<booth_map__c>> bmapMAp=new MAP<string,list<booth_map__c>>();
         
         for(booth_map__c bM:bMap){
             LIST<booth_map__c> bMap1=new LIST<booth_map__c>();
             if(bmapMAp.containsKey(bm.ticket_id__R.tkt_profile__c)){
                 bMap1=bmapMAp.get(bm.ticket_id__R.tkt_profile__c);
                 bmapMAp.put(bm.ticket_id__R.tkt_profile__c,bMap1);
             }else{ 
                 bMap1.add(bm);
                 bmapMAp.put(bm.ticket_id__c,bMap1);
                 
            }
         }
         //system.debug('@@@@'+bmapMAp);
        // system.debug('&&&&&'+TL.Eventtickets);
     for(Ticket__c tc:TL.Eventtickets)  {
         

         Container2 cnt=new Container2();
         
         List<boothContainer> boothContainer=new List<boothContainer>();
         list<booth_map__c> bm1=new list<booth_map__c>();
         
         bm1=bmapMAp.get(tc.id);
         
        //system.debug('globalnest');
        if(tc.Item_Pool__r.Item_Type__r.Name!='Speaker' && tc.Item_Pool__r.Item_Type__r.Name!='Admissions'){
        if(bm1 != null ){
         cnt.tktprofileID=tc.tkt_profile__c==null?'':tc.tkt_profile__c;
         
              for(booth_map__c b: bm1){
                  boothContainer bcnt=new boothContainer();
                  bcnt.BoothName=b.Ticket_id__r.tkt_profile__r.TKT_Company__c==null?'':b.Ticket_id__r.tkt_profile__r.TKT_Company__c;
                  bcnt.BoothArea=b.Booth_Area__c==null?'':b.Booth_Area__c;
                  bcnt.BoothNumber=b.Booth_Number__c==null?'':b.Booth_Number__c;
                  bcnt.Room=b.BLN_Room__r.Name==null?'':b.BLN_Room__r.Name;
                  bcnt.BoothId =b.id==null?'':b.id;
                  bcnt.BoothTicketId =b.Ticket_id__r.Name==null?'':b.Ticket_id__r.Name;
                  boothContainer.add(bcnt);
              }
          }else{
              boothContainer bcnt=new boothContainer();
              bcnt.BoothName='';
              bcnt.BoothArea='';
              bcnt.BoothNumber='';
              bcnt.Room='';
              bcnt.BoothId='';
              bcnt.BoothTicketId='';
              boothContainer.add(bcnt);
          }
          cnt.BoothDetails=boothContainer;
          if(bm1 != null ){
                  contain.add(cnt);
          }
          }
         
          }
            
         }
    TL.EventBoothDetails = contain;
  
       BLN_SeminarsCon semcon=new BLN_SeminarsCon();
        semcon.selectedeventid=EventID;
        semcon.gaterFields();
        semcon.onchangeAct();
        BLN_Event_DAO evdao=new BLN_Event_DAO();
        String timezone;
        List<BLN_Event__c> eve=evdao.getEventDetails(EventID);
        if(eve.size()>0)
        {
           timezone=eve[0].Time_Zone__c;
        }
        
         List<Container> conlist=new List<Container>();
          LIST<Participant__c> patispentspeakerslist = [select id,BLN_TKT_profile__c,BLN_TKT_profile__r.First_Name__c, BLN_TKT_profile__r.Last_Name__c ,(select id,Name from BLN_Participant_Role__r) from Participant__c where Time_Slot__r.Agenda__r.Event__c =:EventID];
        MAP<ID,LIST<string>> rolemap=new MAP<ID,LIST<string>>();
        for(Participant__c p:patispentspeakerslist){
            LIST<string> rlname= new LIST<string>();
            for(BLN_Participant_Role__c r:p.BLN_Participant_Role__r){
                rlname.add(r.name);
            }
            rolemap.put(p.id,rlname);
        }
        for(integer i=0;i<semcon.seminarInn.size();i++)
        {
        
        
           //System.debug('sssssss:'+semcon.seminarInn.size());
            for(integer j=0;j<semcon.seminarInn[i].agendaList.size();j++){
            
                if(semcon.seminarInn[i].agendalist[j].lastmodifieddate > LastmodiFieddateFromMobile){
                Container con=new Container();
                con.PaymentType='Free';
                con.TrackDescription=semcon.seminarInn[i].agendalist[j].Agenda_Description__c==null?'':semcon.seminarInn[i].agendalist[j].Agenda_Description__c;
                con.mySchBool = false;
                for(Time_Slots__c tm:semcon.seminarInn[i].agendaList[j].Time_Slots__r)
                {
                con.AgendaID=semcon.seminarInn[i].agendaList[j].Id;
                con.displayOrder=semcon.seminarInn[i].agendaList[j].Agenda_Display_Order__c;
                //con.ProgrammeName=semcon.seminarInn[i].agendaList[j].Name;
                con.ProgrammeName=semcon.seminarInn[i].agendaList[j].Agenda_Name__c;
                
                Datetime startdate= tm.Slot_Start_date__c;
               // String stringstartdate= startdate.format('yyyy-MM-dd', timezone); 
                String stringstartdate= startdate.format('yyyy-MM-dd', 'GMT');
                
                con.ProgrammeDate=stringstartdate;
               // String stringstarttime= startdate.format('hh:mm a',timezone);
               String stringstarttime= startdate.format('hh:mm a','GMT');
                con.StartTime=stringstarttime;
                Datetime endtime= tm.Slot_End_date__c;
               // String stringendtime= endtime.format('hh:mm a',timezone);
                String stringendtime= endtime.format('hh:mm a','GMT');
                con.EndTime=stringendtime;
                con.programStartDateTime = tm.Slot_Start_date__c;
                con.programEndDateTime = tm.Slot_End_date__c;
                }
                
                con.tktprofiles = new List<tktprofile>(); 
                for(Participant__c pc:semcon.agendaParticipants.get(semcon.seminarInn[i].agendaList[j].id))
                {
                tktprofile gn=new tktprofile();
                gn.tktprofileID=pc.BLN_TKT_profile__c;
                gn.ParticipantRole=rolemap.get(pc.id);
                
                con.tktprofiles.add(gn);
                }
                
                con.ROOMS=new List<ROOM>();
                
                for(Time_Slots__c tm:semcon.seminarInn[i].agendaList[j].Time_Slots__r)
                {
                if(tm.Room__r.NAME!=null){
                ROOM r=new ROOM();
                r.ROOMNAME=tm.Room__r.NAME;
                r.ROOMNUMBER=tm.Room__r.Room_Number__c;
                con.ROOMS.add(r);}
                
                }
                 conlist.add(con);
                }
               

           }
        }
        
     
        BLN_Seminars_updCon semconu=new BLN_Seminars_updCon();
        semconu.selectedeventid=EventID;
        semconu.urlCheck = 'BLN_agenda';
        semconu.groupByoption='Seminargrp';
        semconu.gaterFields();
        semconu.onchangeAct();
        
        MAP<string,string> paymentMAp = new MAP<string,string>();         
        
        LIST<ticket__C> ticlst=new LIST<ticket__C>();
        ticlst = btd.eventSeminarTickets(eventid);
        
        for(ticket__c t:ticlst){
            if(t.tkt_profile__r.BLN_GN_User__r.User__c == Userid)
            trackList.add(t.item_pool__c);
           
            if(!paymentMAp.containskey(t.item_pool__c)){
                 paymentMAp.put(t.item_pool__c,t.item__r.Payment__c);
                 }
        }
        
          List<Container1> conlist1=new List<Container1>();
        
   
     for(integer i=0;i<semconu.seminarInn.size();i++)
        {
           
           for(integer j=0;j<semconu.seminarInn[i].agendaList.size();j++){
          // system.debug('%%%%%%%%%%%%%%%%'+semconu.seminarInn[i].agendalist[j]);
          // system.debug('$$$'+semconu.seminarInn[i].agendalist[j].lastmodifieddate+'============'+LastmodiFieddateFromMobile);
           if(semconu.seminarInn[i].agendalist[j].lastmodifieddate > LastmodiFieddateFromMobile){
         //  system.debug('$$Globalnest');
            Container1 con1=new Container1();
            if(null != paymentMAp){
            if(paymentMAp.containskey(semconu.seminarInn[i].agendaList[j].BLN_Ticket__c)){
            con1.PaymentType =paymentMAp.get(semconu.seminarInn[i].agendaList[j].BLN_Ticket__c);
            }
            }
            
           con1.TrackName=semconu.seminarInn[i].agendaList[j].BLN_Track__r.Name;
           con1.TrackDescription=semconu.seminarInn[i].agendalist[j].Agenda_Description__c==null?'':semconu.seminarInn[i].agendalist[j].Agenda_Description__c;
           
               if(trackList.contains(semconu.seminarInn[i].agendaList[j].BLN_Ticket__c)){
               con1.mySchBool = true;
               //system.debug('myschedule'+semconu.seminarInn[i].agendaList[j].BLN_Track__c);
               }
               else{
               con1.mySchBool = false;
               //system.debug('notmyschedule');
               }
           for(Time_Slots__c tm:semconu.seminarInn[i].agendaList[j].Time_Slots__r)
           {
           con1.AgendaID=semconu.seminarInn[i].agendaList[j].Id;
           con1.displayOrder=semconu.seminarInn[i].agendaList[j].Agenda_Display_Order__c;
           //con1.ProgrammeName=semconu.seminarInn[i].agendaList[j].Name;
           con1.ProgrammeName=semconu.seminarInn[i].agendaList[j].Agenda_Name__c;
           
           Datetime startdate= tm.Slot_Start_date__c;
          // String stringstartdate= startdate.format('yyyy-MM-dd', timezone); 
            String stringstartdate= startdate.format('yyyy-MM-dd', 'GMT'); 
           con1.ProgrammeDate=stringstartdate;
          // String stringstarttime= startdate.format('hh:mm a',timezone);
          String stringstarttime= startdate.format('hh:mm a','GMT');
           con1.StartTime=stringstarttime;
           Datetime endtime= tm.Slot_End_date__c;
          // String stringendtime= endtime.format('hh:mm a',timezone);
           String stringendtime= endtime.format('hh:mm a','GMT');
           con1.EndTime=stringendtime;
           con1.programStartDateTime = tm.Slot_Start_date__c;
           con1.programEndDateTime = tm.Slot_End_date__c;
           }
           
           con1.tktprofiles=new List<tktprofile>();
           
           for(Participant__c pc:semconu.agendaParticipants.get(semconu.seminarInn[i].agendaList[j].id))
           {
              tktprofile gn=new tktprofile();
              gn.tktprofileID=pc.BLN_TKT_profile__c;
              //gn.ParticipantRole=rolemap.get(pc.id);
              //system.debug('partId   '+pc.id);
              list<string> role=new  list<string>();
              role.add(pc.BLN_Participant_Role__r.Name);
                 
                     gn.ParticipantRole=role;
 
              con1.tktprofiles.add(gn);
           }
           
           con1.ROOMS=new List<ROOM>();
           
           for(Time_Slots__c tm:semconu.seminarInn[i].agendaList[j].Time_Slots__r)
           {
           if(tm.Room__r.NAME!=null){
           ROOM r=new ROOM();
           r.ROOMNAME=tm.Room__r.NAME;
           r.ROOMNUMBER=tm.Room__r.Room_Number__c;
           con1.ROOMS.add(r);}
           
           }

           conlist1.add(con1);
           }
          
           }
        }
     
      //Sponsorship details
      BLN_Booth_Map_DAO bmapDAO1 = new BLN_Booth_Map_DAO();
      LIST<BLN_Sponsorships__c> sponslist=bmapDAO1.sponsorshiplist(eventid);
      LIST<sponsorshipContainer> spcontlst= new LIST<sponsorshipContainer>();
      
      for(BLN_Sponsorships__c s: sponslist){
          
          IF(requestedDate == '0000-00-00 00:00:00'){
          sponsorshipContainer spcont= new sponsorshipContainer();
          spcont.DisplayOrder=s.Display_Order__c;
          spcont.LogoSize=s.Logo_Size__c;
          spcont.SponsorshipCategory=s.Sponsorship_Category__c;
          spcont.TicketID=s.Ticket_ID__c;
          spcont.Id=s.Id;
          spcontlst.add(spcont);
          }else IF(s.lastmodifieddate > LastmodiFieddateFromMobile){
              sponsorshipContainer spcont= new sponsorshipContainer();
              spcont.DisplayOrder=s.Display_Order__c;
              spcont.LogoSize=s.Logo_Size__c;
              spcont.SponsorshipCategory=s.Sponsorship_Category__c;
              spcont.TicketID=s.Ticket_ID__c;
              spcont.Id=s.Id;
              spcontlst.add(spcont);
      }
        
      }
        
     TL.SponsorshipDetails = spcontlst;
     TL.Eventschedule = conlist;
      TL.Eventseminar = conlist1;
      TL.siteurl =siteurl1+'/servlet/servlet.ImageServer?oid='+orgid+'&id='; 
      
      return TL;
    
    }
    
     
    
   global class maincontainer {
        public order__c orderInn{get;set;}
        public dateTime dt{get;set;}
        public List<Ticket__c> ticketsInn{get;set;}
        public List<Ticket__c> cancelledTickets{get;set;}
        public payment__c paymentInn{get;set;}
        public List<order_Item__c>  orderItemInn {get;set;}
        public decimal orderPrice{get;set;}
        public List<company__c> compListInner {get;set;}
        public List<Hash_Tag__c> ticketTags{get;set;}
       
        public maincontainer (){
       
        }
       
   
   } 
   
    global class container {
         
        public String AgendaID{get;set;}
        public String ProgrammeName{get;set;}
        public String ProgrammeDate{get;set;}
        public String StartTime{get;set;}
        public String EndTime{get;set;}
        public List<ROOM> ROOMS{get;set;}
        public List<tktprofile> tktprofiles{get;set;}
        public String TrackDescription{get;set;}
        public decimal displayOrder{get;set;}
        public datetime programStartDateTime{get;set;}
        public datetime programEndDateTime{get;set;}
        public boolean mySchBool{get;set;}
        public string PaymentType{get;set;}
      public container (){
       
        }
   } 
   
 global class Container1
      {
        public String AgendaID{get;set;}
        public String ProgrammeName{get;set;}
        public String ProgrammeDate{get;set;}
        public String StartTime{get;set;}
        public String EndTime{get;set;}
        public List<tktprofile> tktprofiles{get;set;}
        public List<ROOM> ROOMS{get;set;}
        public String TrackName{get;set;}
        public String TrackDescription{get;set;}
        public decimal displayOrder{get;set;}
        public datetime programStartDateTime{get;set;}
        public datetime programEndDateTime{get;set;}
        public boolean mySchBool{get;set;}
        public string PaymentType{get;set;}
        public container1 (){
       
        }
        
      }
   
   global class Ordersonly{
   public Order__c OrdersList_info {get ; set ;}
   public Ordersonly(){}
   
   }
    global class ROOM
      {
        public String ROOMNAME{get;set;}
        public String ROOMNUMBER{get;set;}
      }
      global class tktprofile
      {
        public String tktprofileID{get;set;}
        public LIST<String> ParticipantRole{get;set;}
       
      }
       global class boothContainer{
           public string BoothName{get;set;}
           public string BoothArea{get;set;}
           public string BoothNumber{get;set;}
           public string Room{get;set;}
           public String BoothId{get;set;}
           public String BoothTicketId{get;set;}
      }
       global class Container2{
            public String tktprofileID{get;set;}
           public LIST<boothContainer> BoothDetails{get;set;}
      }
   
   global class sponsorshipContainer{
       public Decimal DisplayOrder{get;set;}
       public string LogoSize{get;set;}
       public string SponsorshipCategory{get;set;}
       public string TicketID{get;set;}
       public String Id{get;set;}
  }
   
   global class TotalList{
   public List<maincontainer> TotalLists{get ; set ;}
   public BLN_ASC_MobileAppSettings.MainContainer1  MobileAppSettings {get;set;}
   public list<Ticket__c> Eventtickets{get;set;}
   public list<container> Eventschedule{get;set;}
   public list<container1> Eventseminar{get;set;}
   public list<container2> EventBoothDetails{get;set;}
   public list<sponsorshipContainer> SponsorshipDetails{get;set;}
   public String siteurl{get;set;}
   public string lastmoddate{get;set;}
   public boolean isorder{get;set;}
   public String errorMsg{get;set;}
   
   public TotalList(){
    TotalLists= new List<maincontainer> ();
    Eventschedule = new list<container>();
    EventSeminar = new list<container1>();
    EventBoothDetails = new LIST<container2>();
    SponsorshipDetails = new list<sponsorshipContainer>();
    lastmoddate = string.valueof(system.now());
   }
   
   }
   

}