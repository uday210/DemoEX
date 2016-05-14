public class BLN_ScansforAttendeesCon {

    public String email { get; set; }
    public String cmpny { get; set; }
    public String lastNm { get; set; }
    public String frstNm { get; set; }
    public string selectedeventid{get;set;}
    public BLN_UtillDisplayLinks   myticket{ get; set; }
    public Integer eventdays {get; set;}
    public transient AggregateResult[] leadlist {get;set;}
    public BLN_Event__c event{get;set;}
    //public String selectedDate { get; set; }
    //public LIST<selectOption> filterDates{get;set;}
    //public String selectedTime { get; set; }
    //public LIST<selectOption> filterTime{get;set;}
    public string scanId{get;set;}
    public Datetime fromVal{get;set;}
    public Datetime toVal{get;set;}
    public transient LIST<Lead_Scan__c> detailList{get;set;}
    public boolean viewPopup{get;set;}
    public BLN_Event__c  eventslist{get;set;}
    public date sdate{get;set;}
    public date edate{get;set;}
    public boolean selectAll{get;set;}
    public string uncheckedIds{get;set;}
    
    public BLN_ScansforAttendeesCon(){
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
             if(k!=null){
             selectedeventid = k.getValue();
             }
        //selectedeventid  ='a17L0000001mjHs'; 
        viewPopup=false;
        event= [SELECT start_date__c, end_date__c,Organizer_Email__c,owner.email,Time_Zone__c from BLN_Event__c where id=:selectedeventid]; 
        leadsExport=new LIST<Lead_Scan__c>();
         BLN_Event_DAO eventDAOClass= new BLN_Event_DAO();
            eventInfo= new BLN_EventDetails();
            eventInfo.eventDetailsToDisplay(selectedeventid);
        //selectedDate=String.valueOf(event.start_date__c); 
        //selectedTime='All';
        
        /*list<string> selDatesplit1=string.valueOf(event.start_date__c).split(' ');
        list<string> selDatesplit=selDatesplit1[0].split('-');
        DateTime fromVal1 = DateTime.parse(selDatesplit[1]+'/'+selDatesplit[2]+'/'+selDatesplit[0]+' '+event.Start_Time__c);
        fromVal = fromVal1.format();
        system.debug('event.start_date__c'+event.start_date__c+'         event.Start_Time__c'+event.Start_Time__c);
        list<string> selDatesplit2=string.valueOf(event.end_date__c).split(' ');
        list<string> selDatesplit3=selDatesplit2[0].split('-');
        DateTime toVal1 = DateTime.parse(selDatesplit3[1]+'/'+selDatesplit3[2]+'/'+selDatesplit3[0]+' '+event.End_Time__c);
        toVal =toVal1.format();
        system.debug('aaaaaaaaaaaaaaaaa'+fromVal+'bbbb'+toVal);*/
        
        //fromVal = event.start_date__c;
        //toVal = event.end_date__c;
         sdate = Date.newInstance(event.start_date__c.year(), event.start_date__c.month(),event.start_date__c.day());
         edate = Date.newInstance(event.End_Date__c.year(), event.End_Date__c.month(),event.End_Date__c.day());

        
        //getselectedDate();
        //getselectedTime();

        
    }
    
    public void displayPermissions(){
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
          eventslist = new BLN_Event__c  ();
          try{
            eventslist = blneventdetailbal.eventdetails(selectedeventid);
          }catch(exception e){}
          myticket=new BLN_UtillDisplayLinks(); 
          myticket.isLeadExpand='expand';
          myticket.isLeadReport='active';
          myticket.tablabel='Attendee Scans Report';
          myticket.iseventsExpand ='';
          try{
          myticket.eventName = eventslist.Name;
          }catch(exception e){}
          myticket.EventId = selectedeventid;
          myticket.userPermissions(userInfo.getUserId(),selectedeventid);
          
          mainMethod();
    }
    
    public void displayPermissions1(){
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
          eventslist = new BLN_Event__c  ();
          try{
            eventslist = blneventdetailbal.eventdetails(selectedeventid);
          }catch(exception e){}
          myticket=new BLN_UtillDisplayLinks(); 
          myticket.isLeadExpand='expand';
          myticket.isLeadReport='active';
          myticket.tablabel='Attendee Scans Report';
          myticket.iseventsExpand ='';
          try{
          myticket.eventName = eventslist.Name;
          }catch(exception e){}
          myticket.EventId = selectedeventid;
          myticket.userPermissions(userInfo.getUserId(),selectedeventid);

    }
    
    public datetime fromconvrtedvalue {get;set;}
    public datetime toconvrtedvalue {get;set;}
    
    public void go(){
    string fromVal11;
    string toVal11;
    string hrs1;
        if(fromVal!=null){
               system.debug('fromvalue   '+fromVal);
             string sfromval = String.valueOf(fromVal);
             
             //string fromconvrtedvalue1 = String.valueOf(fromconvrtedvalue);
             string[] lststrnf = String.valueOf(fromVal).split(' ');
             string[] lststrnf1 = lststrnf[0].split('-');
             string[] ftme = lststrnf[1].split(':');
             integer hrs = Integer.valueOf(ftme[0]);
             
             if(hrs>12) {
             hrs = hrs-12;
             hrs1 = hrs +':'+ftme[1] + ' '+'PM';
             }
             else if(hrs==0){
             hrs = 12;
             hrs1 = hrs +':'+ftme[1] + ' '+'AM';
             }
             else{
             hrs1 = hrs +':'+ftme[1] + ' '+'AM';
             }
             system.debug('hrs11111'+hrs1);
             
             fromVal11 = lststrnf1[1]+'/'+lststrnf1[2]+'/'+lststrnf1[0]+' '+hrs1;
             BLN_timeConToEvzoneCon timezone = new BLN_timeConToEvzoneCon();
             fromconvrtedvalue = timezone.getDateBasedOnEventTimeZone(fromVal11,selectedeventid);
             system.debug('converted datetime aaa   '+fromVal11);
        }
        else{
            fromconvrtedvalue = null;
        }
        if(toVal!=null){
             string stoval = String.valueOf(toval);
             
             //string toconvrtedvalue1 = String.valueOf(toconvrtedvalue);
             string[] lststrnt = String.valueOf(toval).split(' ');
             string[] lststrnt1 = lststrnt[0].split('-');
             string[] ttme = lststrnt[1].split(':');
             integer hrs = Integer.valueOf(ttme[0]);
             
             if(hrs>12) {
             hrs = hrs-12;
             hrs1 = hrs +':'+ttme[1] + ' '+'PM';
             }
             else if(hrs==0){
             hrs = 12;
             hrs1 = hrs +':'+ttme[1] + ' '+'AM';
             }
             else{
             hrs1 = hrs +':'+ttme[1] + ' '+'AM';
             }
             toVal11 = lststrnt1[1]+'/'+lststrnt1[2]+'/'+lststrnt1[0]+' '+hrs1;
             BLN_timeConToEvzoneCon timezone = new BLN_timeConToEvzoneCon();
             toconvrtedvalue = timezone.getDateBasedOnEventTimeZone(toVal11,selectedeventid);
             system.debug('converted datetime bbb   '+toVal11);
        }
        else{
            toconvrtedvalue = null;
        }
        if(event.Organizer_Email__c==UserInfo.getUserEmail()||event.owner.email==UserInfo.getUserEmail()){
            leadlist= [SELECT count(id) cnt,MAX(Cell_Phone__c) phone,MAX(title__c) title,MAX(Company__c) company,MAX(First_Name__c) fname,MAX(Last_Name__c) lname,MAX(Lead_Email__c) email,BLN_TKT_profile__c i  from Lead_Scan__c where Lead_Status__c!='Deleted' AND Event__c =:selectedeventid AND Scan_Time__c >=:fromconvrtedvalue AND Scan_Time__c<=:toconvrtedvalue group by BLN_TKT_profile__c ORDER BY count(id) DESC];
        }else{
            leadlist= [SELECT count(id) cnt,MAX(Cell_Phone__c) phone,MAX(title__c) title,MAX(Company__c) company,MAX(First_Name__c) fname,MAX(Last_Name__c) lname,MAX(Lead_Email__c) email,BLN_TKT_profile__c i  from Lead_Scan__c where Lead_Status__c!='Deleted' AND Event__c =:selectedeventid AND Scan_Time__c >=:fromconvrtedvalue AND Scan_Time__c<=:toconvrtedvalue AND Scanner_User__r.User__c=:UserInfo.getUserId() group by BLN_TKT_profile__c ORDER BY count(id) DESC];        
        }
    }
    
    public void mainMethod(){
        //eventdays = event.start_date__c.daysBetween(event.end_date__c);
        if(event.Organizer_Email__c==UserInfo.getUserEmail()||event.owner.email==UserInfo.getUserEmail()){
        leadlist= [SELECT count(id) cnt,MAX(Cell_Phone__c) phone,MAX(title__c) title,MAX(Company__c) company,MAX(First_Name__c) fname,MAX(Last_Name__c) lname,MAX(Lead_Email__c) email,BLN_TKT_profile__c i  from Lead_Scan__c where Lead_Status__c!='Deleted' AND Event__c =:selectedeventid group by BLN_TKT_profile__c ORDER BY count(id) DESC];
        }else{
        leadlist= [SELECT count(id) cnt,MAX(Cell_Phone__c) phone,MAX(title__c) title,MAX(Company__c) company,MAX(First_Name__c) fname,MAX(Last_Name__c) lname,MAX(Lead_Email__c) email,BLN_TKT_profile__c i  from Lead_Scan__c where Lead_Status__c!='Deleted' AND Event__c =:selectedeventid AND Scanner_User__r.User__c=:UserInfo.getUserId() group by BLN_TKT_profile__c ORDER BY count(id) DESC];
        }

            }
    
    
    public void scanDetails(){
        string scaneeID = Apexpages.currentPage().getParameters().get('scanee');
        system.debug('scaneeID'+scaneeID);
        detailList=[SELECT Scan_Time__c,Scanner_User__c,Scanner_Company__r.Name,Scanner_User__r.First_Name__c,Scanner_User__r.Last_Name__c from Lead_Scan__c where Lead_Status__c!='Deleted' AND Event__c =:selectedeventid and BLN_TKT_profile__c =:scaneeID order by scan_time__c desc];
        list<ID> scaner=new list<ID>();
        for(Lead_Scan__c ld:detailList){
            scaner.add(ld.Scanner_User__c);
        }
        LIST<booth_map__c> bm=new LIST<booth_map__c>();
        bm=[SELECT booth_number__c,Ticket_id__r.tkt_profile__r.BLN_GN_User__c from booth_map__c where Ticket_id__r.tkt_profile__r.BLN_GN_User__c= :scaner and Ticket_id__r.ticket_status__c = 'Booked'];
        system.debug('boothmap'+bm.size());
        MAP<string,LIST<booth_map__c>> bMap=new MAP<string,LIST<booth_map__c>>();
        for(booth_map__c b:bm){
            LIST<booth_map__c> bms=new LIST<booth_map__c>();
            if(bMap.containsKey(b.Ticket_id__r.tkt_profile__r.BLN_GN_User__c)){
                bms=bMap.get(b.Ticket_id__r.tkt_profile__r.BLN_GN_User__c);
                bms.add(b);
                bMap.put(b.Ticket_id__r.tkt_profile__r.BLN_GN_User__c,bms);
            }else{
                bms.add(b);
                bMap.put(b.Ticket_id__r.tkt_profile__r.BLN_GN_User__c,bms);
            }
        }
        detailInner=new list<detailInn>();
        for(Lead_Scan__c l:detailList){
            LIST<booth_map__c> boothnum=new LIST<booth_map__c>();
            string bnum='';
            boothnum = bMap.get(l.Scanner_User__c);
            if(null!= boothnum){
            if(boothnum.size()>0){
                for(booth_map__c b:boothnum){
                    if(bnum!= '')
                    bnum+=',';
                    bnum+=b.booth_number__c;
                }
            }
            }
            //detailInner.add(new detailInn(boothnum.booth_number__c,l.Scan_Time__c,l.Scanner_User__r.First_Name__c,l.Scanner_User__r.Last_Name__c));
            detailInn Inn=new detailInn();
            //if(boothnum!=null){
            inn.boothno=bnum;
            /*}else{
            inn.boothno='';
            }*/
            //inn.scantime=l.Scan_Time__c;
            BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
            tz.tZone=Event.Time_Zone__c;
            tz.format='MM/dd/yyyy hh:mm a';
            tz.dateTimeValue=l.Scan_Time__c;
            inn.scantime=tz.getTimeZoneValue();
            inn.fname=l.Scanner_User__r.First_Name__c;
            inn.lname=l.Scanner_User__r.Last_Name__c;
            inn.company = l.Scanner_Company__r.Name;
            detailInner.add(Inn);
            
        }
        system.debug('detailList'+detailList);
        viewPopup=true;
    }
    
    public transient list<detailInn> detailInner{get;set;}
    public class detailInn{
        public string boothno{get;set;}
        public string scantime{get;set;}
        public string fname{get;set;}
        public string lname{get;set;}
        public string company{get;set;}
    }
    
    public BLN_EventDetails eventInfo{get; set;}
    public PageReference printReport() {
        BLN_Event_DAO eventDAOClass= new BLN_Event_DAO();
            eventInfo= new BLN_EventDetails();
            eventInfo.eventDetailsToDisplay(selectedeventid);
           // pageReference pg =  new pagereference('/apex/BLN_printScansforAttendees');
           // return pg;
           
       String selectedck=apexpages.currentpage().getparameters().get('selectedck');
       String uncheckedIds=apexpages.currentpage().getparameters().get('unchecked');
       String type=apexpages.currentpage().getparameters().get('type');
       string searchkey=apexpages.currentpage().getparameters().get('searchkey');
       
       system.debug('11111111111111111111111111'+exportlist);
       if(type== 'Summary'){ 
            pageReference pg =  page.BLN_printScansforAttendees;
            system.debug('ssssssssssssssssssssssssssss'+pg);
            pg.setredirect(true);
            pg.getParameters().put('selectedck',selectedck);
             pg.getParameters().put('unchecked',uncheckedIds);
             pg.getParameters().put('type',type);
             pg.getParameters().put('selectAll',string.valueOf(selectAll));
             pg.getParameters().put('fromVal',string.valueOf(fromVal));
             pg.getParameters().put('toVal',string.valueOf(toVal));
             pg.getParameters().put('searchkey',searchkey);
            return pg;
      }else{
          return null;
      }
    }


    public transient AggregateResult[] exportlist{get;set;}
    public PageReference exportReport() {
       String selectedck=apexpages.currentpage().getparameters().get('selectedck');
       String uncheckedIds=apexpages.currentpage().getparameters().get('unchecked');
       String type=apexpages.currentpage().getparameters().get('type');
       string searchkey=apexpages.currentpage().getparameters().get('searchkey');
       
       if(type== 'Summary'){ 
        pageReference pg =  new pagereference('/apex/BLN_exportScansforAttendees');
            pg.setredirect(true);
             pg.getParameters().put('selectedck',selectedck);
             pg.getParameters().put('unchecked',uncheckedIds);
             pg.getParameters().put('type',type);
             pg.getParameters().put('selectAll',string.valueOf(selectAll));
             pg.getParameters().put('fromVal',string.valueOf(fromVal));
             pg.getParameters().put('toVal',string.valueOf(toVal));
             pg.getParameters().put('searchkey',searchkey);
            return pg;
      }else{
          pageReference pg =  new pagereference('/apex/BLN_exportScansforAttendees1');
            pg.setredirect(true);
             pg.getParameters().put('selectedck',selectedck);
             pg.getParameters().put('unchecked',uncheckedIds);
             pg.getParameters().put('type',type);
             pg.getParameters().put('selectAll',string.valueOf(selectAll));
             pg.getParameters().put('fromVal',string.valueOf(fromVal));
             pg.getParameters().put('toVal',string.valueOf(toVal));
             pg.getParameters().put('searchkey',searchkey);
            return pg;
      }
    }
    public transient MAP<ID,LIST<detailInn>> detailInnMAp{get;set;}
    public void exportMethod(){
        String selectedck=apexpages.currentpage().getparameters().get('selectedck');
        System.debug('hi seconf page '+selectedck);
        String tok1 = selectedck.replace('\"','');
        String tok2 = tok1.replace(']','');
        String tok4 = tok2.replace('\'','');
        String tok3 = tok4.replace('[','');
          
        List<String> allIds= tok3.split(',');
        system.debug('iiii'+allIds[0]);

        String uncheckedIds=apexpages.currentpage().getparameters().get('unchecked');
        System.debug('hi unchecked '+uncheckedIds);
        String tok5 = uncheckedIds.replace('\"','');
        String tok6 = tok5.replace(']','');
        String tok7 = tok6.replace('\'','');
        String tok8 = tok7.replace('[','');
          
        List<String> uncheckedIdList= tok8.split(',');
        system.debug('uuuuu'+uncheckedIdList.size());
        
        String selectAll=apexpages.currentpage().getparameters().get('selectAll');
        String type=apexpages.currentpage().getparameters().get('type');
        string fdt=apexpages.currentpage().getparameters().get('fromVal');
        string searchkey=apexpages.currentpage().getparameters().get('searchkey');
        
        if(fdt != '' && fdt != null){
        Datetime fromVal=Datetime.Valueof(fdt);
        }else{
        Datetime fromVal=null;
        }
        string tdt = apexpages.currentpage().getparameters().get('toVal');
        if(tdt != '' && tdt != null){
        Datetime toVal=Datetime.Valueof(tdt);
        }else{
        Datetime toVal=null;
        }
        set<id> sidSet=new set<id>();
        system.debug('selectAll '+selectAll );
        if(selectAll == 'true'){
            
            exportlist= [SELECT count(id) cnt,MAX(Cell_Phone__c) phone,MAX(title__c) title,MAX(Company__c) company,MAX(First_Name__c) fname,MAX(Last_Name__c) lname,MAX(Lead_Email__c) email,BLN_TKT_profile__c i  from Lead_Scan__c where Lead_Status__c!='Deleted' AND Event__c =:selectedeventid AND Scan_Time__c >=:fromVal AND Scan_Time__c<=:toVal AND BLN_TKT_profile__c NOT IN :uncheckedIdList
                            AND (First_Name__c like : '%'+searchkey+'%' OR Last_Name__c like : '%'+searchkey+'%' OR Lead_Email__c like : '%'+searchkey+'%' OR Company__c like : '%'+searchkey+'%' OR Title__c like : '%'+searchkey+'%')
                          group by BLN_TKT_profile__c ORDER BY count(id) DESC];
            
            if(type == 'Detail'){
                for(AggregateResult el:exportlist){
                    sidSet.add(string.valueof(el.get('i')));
                }
                detailList=[SELECT Scan_Time__c,Scanner_User__c,BLN_TKT_profile__c,Scanner_Company__r.Name,Scanner_User__r.First_Name__c,Scanner_User__r.Last_Name__c from Lead_Scan__c where Lead_Status__c!='Deleted' AND Event__c =:selectedeventid and BLN_TKT_profile__c IN: sidSet AND Scan_Time__c >=:fromVal AND Scan_Time__c<=:toVal order by scan_time__c desc];
                list<ID> scaner=new list<ID>();
                for(Lead_Scan__c ld:detailList){
                    scaner.add(ld.Scanner_User__c);
                }
                LIST<booth_map__c> bm=new LIST<booth_map__c>();
                bm=[SELECT booth_number__c,Ticket_id__r.tkt_profile__r.BLN_GN_User__c from booth_map__c where Ticket_id__r.tkt_profile__r.BLN_GN_User__c= :scaner and Ticket_id__r.ticket_status__c = 'Booked'];
                MAP<string,LIST<booth_map__c>> bMap=new MAP<string,LIST<booth_map__c>>();
                for(booth_map__c b:bm){
                //bMap.put(b.Ticket_id__r.tkt_profile__r.BLN_GN_User__c,b);
                LIST<booth_map__c> bms=new LIST<booth_map__c>();
                if(bMap.containsKey(b.Ticket_id__r.tkt_profile__r.BLN_GN_User__c)){
                    bms=bMap.get(b.Ticket_id__r.tkt_profile__r.BLN_GN_User__c);
                    bms.add(b);
                    bMap.put(b.Ticket_id__r.tkt_profile__r.BLN_GN_User__c,bms);
                }else{
                    bms.add(b);
                    bMap.put(b.Ticket_id__r.tkt_profile__r.BLN_GN_User__c,bms);
                }
                }
                //detailInner=new list<detailInn>();
                detailInnMAp = new MAP<ID,LIST<detailInn>>();
                for(Lead_Scan__c l:detailList){
                    LIST<booth_map__c> boothnum=new LIST<booth_map__c>();
                    boothnum = bMap.get(l.Scanner_User__c);
                    string bnum='';
                    if(null!= boothnum){
                    if(boothnum.size()>0){
                        for(booth_map__c b:boothnum){
                            if(bnum!= '')
                            bnum+=',';
                            bnum+=b.booth_number__c;
                        }
                    }
                    }
                    detailInn Inn=new detailInn();
                    inn.boothno=bnum;
                    BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
                        tz.tZone=Event.Time_Zone__c;
                        tz.format='MM/dd/yyyy hh:mm a';
                        tz.dateTimeValue=l.Scan_Time__c;
                        inn.scantime=tz.getTimeZoneValue();
                    inn.fname=l.Scanner_User__r.First_Name__c;
                    inn.lname=l.Scanner_User__r.Last_Name__c;
                    inn.company = l.Scanner_Company__r.Name;
                    //detailInner.add(Inn);
                    LIST<detailInn> inns=new LIST<detailInn>();
                    if(detailInnMAp.containsKey(l.BLN_TKT_profile__c)){
                        inns = detailInnMAp.get(l.BLN_TKT_profile__c);
                        inns.add(inn);
                        detailInnMAp.put(l.BLN_TKT_profile__c,inns);
                    }else{
                        inns.add(inn);
                        detailInnMAp.put(l.BLN_TKT_profile__c,inns);
                    }
                }
            }
        }else{
            
                exportlist= [SELECT count(id) cnt,MAX(Cell_Phone__c) phone,MAX(title__c) title,MAX(Company__c) company,MAX(First_Name__c) fname,MAX(Last_Name__c) lname,MAX(Lead_Email__c) email,BLN_TKT_profile__c i  from Lead_Scan__c where Lead_Status__c!='Deleted' AND Event__c =:selectedeventid AND Scan_Time__c >=:fromVal AND Scan_Time__c<=:toVal AND BLN_TKT_profile__c IN :allIds  
                                AND (First_Name__c like : '%'+searchkey+'%' OR Last_Name__c like : '%'+searchkey+'%' OR Lead_Email__c like : '%'+searchkey+'%' OR Company__c like : '%'+searchkey+'%' OR Title__c like : '%'+searchkey+'%')
                              group by BLN_TKT_profile__c ORDER BY count(id) DESC]; 
            if(type == 'Detail'){
                for(AggregateResult el:exportlist){
                    sidSet.add(string.valueof(el.get('i')));
                }
                detailList=[SELECT Scan_Time__c,Scanner_User__c,Scanner_Company__r.Name,BLN_TKT_profile__c,Scanner_User__r.First_Name__c,Scanner_User__r.Last_Name__c from Lead_Scan__c where Lead_Status__c!='Deleted' AND Event__c =:selectedeventid and BLN_TKT_profile__c IN: sidSet AND Scan_Time__c >=:fromVal AND Scan_Time__c<=:toVal order by scan_time__c desc];
                list<ID> scaner=new list<ID>();
                for(Lead_Scan__c ld:detailList){
                    scaner.add(ld.Scanner_User__c);
                }
                LIST<booth_map__c> bm=new LIST<booth_map__c>();
                bm=[SELECT booth_number__c,Ticket_id__r.tkt_profile__r.BLN_GN_User__c from booth_map__c where Ticket_id__r.tkt_profile__r.BLN_GN_User__c= :scaner and Ticket_id__r.ticket_status__c = 'Booked'];
                MAP<string,LIST<booth_map__c>> bMap=new MAP<string,LIST<booth_map__c>>();
                for(booth_map__c b:bm){
                //bMap.put(b.Ticket_id__r.tkt_profile__r.BLN_GN_User__c,b);
                LIST<booth_map__c> bms=new LIST<booth_map__c>();
                if(bMap.containsKey(b.Ticket_id__r.tkt_profile__r.BLN_GN_User__c)){
                    bms=bMap.get(b.Ticket_id__r.tkt_profile__r.BLN_GN_User__c);
                    bms.add(b);
                    bMap.put(b.Ticket_id__r.tkt_profile__r.BLN_GN_User__c,bms);
                }else{
                    bms.add(b);
                    bMap.put(b.Ticket_id__r.tkt_profile__r.BLN_GN_User__c,bms);
                }
                }
                //detailInner=new list<detailInn>();
                detailInnMAp = new MAP<ID,LIST<detailInn>>();
                for(Lead_Scan__c l:detailList){
                     LIST<booth_map__c> boothnum=new LIST<booth_map__c>();
                    boothnum = bMap.get(l.Scanner_User__c);
                    string bnum='';
                    if(null!= boothnum){
                    if(boothnum.size()>0){
                        for(booth_map__c b:boothnum){
                            if(bnum!= '')
                            bnum+=',';
                            bnum+=b.booth_number__c;
                        }
                        
                    }else{
                        bnum+=boothnum[0].booth_number__c;
                    }
                    }
                    detailInn Inn=new detailInn();
                    inn.boothno=bnum;
                         BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
                        tz.tZone=Event.Time_Zone__c;
                        tz.format='MM/dd/yyyy hh:mm a';
                        tz.dateTimeValue=l.Scan_Time__c;
                        inn.scantime=tz.getTimeZoneValue();
                    inn.fname=l.Scanner_User__r.First_Name__c;
                    inn.lname=l.Scanner_User__r.Last_Name__c;
                        inn.company = l.Scanner_Company__r.Name;
                    //detailInner.add(Inn);
                    LIST<detailInn> inns=new LIST<detailInn>();
                    if(detailInnMAp.containsKey(l.BLN_TKT_profile__c)){
                        inns = detailInnMAp.get(l.BLN_TKT_profile__c);
                        inns.add(inn);
                        detailInnMAp.put(l.BLN_TKT_profile__c,inns);
                    }else{
                        inns.add(inn);
                        detailInnMAp.put(l.BLN_TKT_profile__c,inns);
                    }
                }
            }
        }
    }
    
    public transient LIST<Lead_Scan__c> allLeads{get;set;}
    public PageReference exportAll() {
        BLN_LeadScan_DAO lsDAo =new BLN_LeadScan_DAO();
        
        pageReference pg =  new pagereference('/apex/BLN_exportAllScansforAttendees');
        pg.setredirect(true);
        return pg;
    }
    
     public PageReference exportallmethod() {
        allLeads=new LIST<Lead_Scan__c>();
        string querystring ='SELECT event__r.time_zone__c,First_Name__c,Lead_Email__c,title__c,Last_Name__c,Scanner_User__r.Email__c,Prefix__c,followup_date__c,notes__c,Rating__c,Suffix__c,Company__c,Work_Phone__c,City__c,user_pic__c,zip__c,Scanner_Company__r.Name,BLN_TKT_profile__r.Name,Scanner_User__r.Name,Scanner_User__r.First_Name__c,Scanner_User__r.Last_Name__c,Cell_Phone__c,Scan_Time__c,Event__r.Name FROM Lead_Scan__c WHERE  Lead_Status__c!=\'Deleted\' AND Event__c =\''+ selectedeventid+'\' Order By BLN_TKT_profile__r.First_name__c,BLN_TKT_profile__r.last_name__c';
        allLeads = [SELECT event__r.time_zone__c,First_Name__c,Lead_Email__c,title__c,Last_Name__c,Scanner_User__r.Email__c,Prefix__c,followup_date__c,notes__c,Rating__c,Suffix__c,Company__c,Work_Phone__c,City__c,user_pic__c,zip__c,Scanner_Company__r.Name,BLN_TKT_profile__r.Name,Scanner_User__r.Name,Scanner_User__r.First_Name__c,Scanner_User__r.Last_Name__c,Cell_Phone__c,Scan_Time__c,Event__r.Name FROM Lead_Scan__c WHERE  Lead_Status__c!='Deleted' AND Event__c =: selectedeventid Order By BLN_TKT_profile__r.First_name__c,BLN_TKT_profile__r.last_name__c];
        if(allLeads.size()>5000){
            Id batchInstanceId = Database.executeBatch(new BLN_ExportScansforAttendeesBatch(querystring,allLeads[0].event__r.time_zone__c), 5000);
            //return new Pagereference('/BLN_AttendeeScanReportCheckEmail');
            return null;
        }else{
            return null;
        }
    }

    public LIST<Lead_Scan__c> leadsExport{get;set;}
    public PageReference exportedMailData() {
        leadsExport=new LIST<Lead_Scan__c>();
        leadsExport= [SELECT event__r.time_zone__c,First_Name__c,Lead_Email__c,title__c,Last_Name__c,Scanner_User__r.Email__c,Prefix__c,followup_date__c,notes__c,Rating__c,Suffix__c,Company__c,Work_Phone__c,City__c,user_pic__c,zip__c,Scanner_Company__r.Name,BLN_TKT_profile__r.Name,Scanner_User__r.Name,Scanner_User__r.First_Name__c,Scanner_User__r.Last_Name__c,Cell_Phone__c,Scan_Time__c,Event__r.Name FROM Lead_Scan__c WHERE  Lead_Status__c!='Deleted' AND Event__c =: selectedeventid Order By BLN_TKT_profile__r.First_name__c,BLN_TKT_profile__r.last_name__c];
        return null;
    }
    

        @RemoteAction
        public static boolean getCheckTypeOfExportForTotalScans(string evntid){
        boolean showbulkbtn = false;



        Integer totalResp = 0;

        string querystring='SELECT COUNT()'
          +' FROM Lead_Scan__c '
          +'WHERE Lead_Status__c!=\'Deleted\' AND Event__c= \''+evntid+'\' Limit 5001';
          
         

        totalResp = Database.countQuery(querystring);
        system.debug('---Count---'+totalResp );






        if(totalResp>5000){

        showbulkbtn = true;
        }


        return showbulkbtn;
        }


}