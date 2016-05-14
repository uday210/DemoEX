global with sharing class BLN_Importscans {
public string selectedeventid{get;set;}
public Blob csvFileBody{get;set;}
public list<wraptstausrec> tstatus_warp;
public ticketwrap ticwrap;
public map<string,string> badgeidsmap;
public list<wraptstausrec> failuretstatus_wrap;
    public string csvAsString{get;set;}    
    public List<List<String>> allFields{get;set;}
    public List<header> gridrows{get;set;}
    public string badgeId{get;set;}
    public string scanTime{get;set;}
    public List<SelectOption> fieldsoptions{get;set;}
    public string compid{get;set;}
    public string loginusergnid{get;set;}
    public id LoginUserID{get;set;}
    public GN_User__c gn{get;set;}
    BLN_timeConToEvzoneCon timezonecl=new BLN_timeConToEvzoneCon();
    Public BLN_UtillDisplayLinks  myticket{get;set;}
    public  BLN_Event__c ev{get;set;}
    public Map<string,datetime> bdge_nd_scantime_map;
    public Map<string,string> bdge_nd_device_map;
    
    public BLN_Importscans(){
    BLN_Gnuser_DAO gndao= new BLN_Gnuser_DAO();
    LoginUserID = UserInfo.getUserId();
    system.debug('####'+LoginUserID);
        gn=gndao.gettinggnuser(LoginUserID);
        loginusergnid=gn.id;
        compid=gn.Default_Company_ID__c;
        selectedeventid = Apexpages.currentPage().getParameters().get('id');
         if(selectedeventid ==null){
               Cookie k = ApexPages.currentPage().getCookies().get('counter');
             if(k!=null){
             selectedeventid = k.getValue();
             }
             }
         BLN_Events_DAO evndao = new BLN_Events_DAO();
         ev = evndao.getEventtimezone(selectedeventid);
         myticket = new BLN_UtillDisplayLinks();
         myticket.isReportsPageExpand='expand';
         myticket.isCheckinHistoryReportPage ='active';
         myticket.tablabel='Import Scans';
         myticket.eventName = ev.Name;
         myticket.EventId= selectedeventid;
         myticket.userPermissions(userInfo.getUserId(),selectedeventid); 
        }
   
    public PageReference importCSVFile() 
    {
        if(csvFileBody==null)
        {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select a File.');
            ApexPages.addMessage(myMsg);
            return null;
        }
        String csvAsString = blobToString( csvFileBody,'ISO-8859-1');
       // String csvAsString = csvFileBody.toString();
        allFields=BLN_ImportAttendeesCon.parseCSV(csvAsString,false);
        List<String> headerrow=new List<String>();
        gridrows=new List<header>();
        fieldsoptions = new list<selectoption>();
        fieldsoptions.add(new selectoption('None','--None--'));
        fieldsoptions.add(new selectoption('Custom_Barcode__c','Custom Barcode'));
        fieldsoptions.add(new selectoption('Scan_Date__c','Scan Date'));
        fieldsoptions.add(new selectoption('Scan_Time__c','Scan Time'));
        fieldsoptions.add(new selectoption('Scan_Device','Scan Device'));
        system.debug('allFields============'+allFields[0]);
        for(String s:allFields[0])
        {
        system.debug('s=================='+s);
            header gr=new header();
            gr.csvheader=s;
            system.debug('gr.csvheader=====raje'+gr.csvheader);
            system.debug('fieldsoptions====='+fieldsoptions);
            For(SelectOption so : fieldsoptions)
            {
            system.debug('gr.csvheader==='+gr.csvheader);
            system.debug('so.getlabel==='+so.getlabel());
                if(gr.csvheader.contains(so.getlabel()))
                {
                    gr.field=so.getvalue();
                    system.debug('gr.field==========='+gr.field);
                    break;
                }
            }
            system.debug('gr============='+gr);
            gridrows.add(gr);
        }                
        return null;
    }  
    
    
    public class header
    {
        public String csvheader{get;set;}
        public String field{get;set;}     
    }
    
    public list<string> badgeIdList{set;get;}
    public list<datetime> scantimeList{set;get;}
    public list<string> deviceList{set;get;}
    public map<string,string> ticketMap{set;get;}
     datetime sTimeled;
     String str;
    public PageReference Import()
    {
    badgeIdList= new list<string>();
    
    tstatus_warp =new list<wraptstausrec>();
    failuretstatus_wrap = new list<wraptstausrec>();
    badgeidsmap = new map<string,string>();
    scantimeList=  new list<datetime>();
    deviceList = new list<string>();
    boolean badgeIdExist=false,scanTimeExist=false,scanDateExist=false,scanDevise=false;
    bdge_nd_scantime_map = new map<string , datetime>();
    bdge_nd_device_map = new map<string,string>();
    BLN_Ticket_DAO tidao=new BLN_Ticket_DAO();   
         set<string> stbardge=new set<string>();
         for(ticket__c lict: tidao.getAllbadges(selectedeventid)){
            if(lict.Badge_ID__c !=null){
              stbardge.add(lict.Badge_ID__c);
              }
            if(lict.Scan_Id__c !=null){
              stbardge.add(lict.Scan_Id__c );
              }
            if(lict.Custom_Barcode__c  !=null){
              stbardge.add(lict.Custom_Barcode__c);
              }
        }
 
    if(gridrows.size()!=0)
    {
        for(header e:gridrows)
        {
          if(e.field=='Custom_Barcode__c')
          badgeIdExist=true;
          if(e.field=='Scan_Time__c')
          scanTimeExist=true;    
          if(e.field=='Scan_Date__c')
          scanDateExist=true; 
          if(e.field=='Scan_Device')
          scanDevise=true;  
        }
    }
    if(csvFileBody==null)
    {
    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select a File.');
    ApexPages.addMessage(myMsg);
    return null;
    }
    if(allFields.size()==1)
    {
    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter atleast one record in the file');
    ApexPages.addMessage(myMsg); 
    return null;
    }
    system.debug('@@@'+badgeIdExist+'$$$'+scanTimeExist+'&&&&&'+scanDateExist+'%%'+scanDevise);
    if(badgeIdExist==true&&scanTimeExist==true&&scanDateExist==true&&scanDevise==true)
    {
    allFields.remove(0);
    
    for(integer i=0;i<allFields.size();i++)
      {
           List<String> eachrowrecord=allFields[i];
           string bid = null;
           string dtsc = null;
           string dtsctime = null;
           string devisename = null;
           sTimeled = null;
           for(integer j=0;j<gridrows.size();j++)
           {
              if(gridrows[j].field!='')
              {
                  if(gridrows[j].field=='Custom_Barcode__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                  badgeIdList.add(eachrowrecord[j]);
                  bid = eachrowrecord[j];
                  }
                  }
                  if(gridrows[j].field=='Scan_Date__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                  dtsc = eachrowrecord[j];
                  
                  }
                  }         
                  if(gridrows[j].field=='Scan_Time__c'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                  dtsctime = eachrowrecord[j];
                  } 
                  }
                  if(gridrows[j].field=='Scan_Device'){
                  if(eachrowrecord[j]!=null&&eachrowrecord[j]!=''){
                  devisename = eachrowrecord[j];
                  } 
                  }   
              }
           }    
                  if(dtsc!=null && dtsctime !=null){//&& dtsctime !=null
                  try{
                  string scdate = getformateddate(dtsc+' '+dtsctime);
                  //string scdate = getformateddate(dtsc);
                  system.debug('%%%%%%%%%%%%%'+scdate);
                  system.debug('%%%%%%%%%%%%%********'+timezonecl.getDateBasedOnEventTimeZone(scdate,'GMT',ev.Time_Zone__c));
                  sTimeled=timezonecl.getDateBasedOnEventTimeZone(scdate,'GMT',ev.Time_Zone__c);
                  }catch(Exception e){}
                  }
                  scantimeList.add(sTimeled);
                  deviceList.add(devisename);
              if(bid !=Null){
              badgeidsmap.put(bid,bid);
              }
              if(bid !=Null && dtsc != NULL && devisename  != NULL && dtsctime   != NULL && sTimeled !=NULL){    
                  try{
                  if(stbardge.contains(bid)){
                  tstatus_warp.add(new wraptstausrec(devisename,'Import',sTimeled ,bid ));
                   }else if(!stbardge.contains(bid)){
                    failuretstatus_wrap.add(new wraptstausrec(devisename,'Import',sTimeled ,bid));
                   }
                  }catch(Exception e){}
               }else{
                try{
               failuretstatus_wrap.add(new wraptstausrec(devisename,'Import',sTimeled ,bid));
                }catch(Exception e){}
              }
          
          
        }
         system.debug('##############'+tstatus_warp);
        tstatus_warp.sort();
        system.debug('@@@@@@'+tstatus_warp);
        system.debug('@@@@@@failuretstatus_wrap'+failuretstatus_wrap);
         BLN_Ticket_DAO tkdsy = new BLN_Ticket_DAO();
         list<ticket__c> tc = new list<ticket__c>();
         list<Ticket__c> newlcsinsert= new list<Ticket__c>();
        
          
         if(badgeIdList.size()>0){
         try{
           tc=tkdsy.getcustombarcodesyc(badgeIdList,selectedeventid); 
            }catch(Exception e){}
               }
               
                integer duplicateRecords=0;
                               
                 map<id,datetime> tkt_scantime_map =new map<id,datetime>();
                 map<id,string> tkt_device_map =new map<id,string>();
                 map<id,ticket__c> tickets ;
                 
                 map<string,ticketwrap> bdge_nd_ticketwrap = new map<string,ticketwrap>();
                for(ticket__c t:tc){
                 tickets   = new map<id,ticket__c>(tc);
                      if(t.Tstatus_Id__c !=null){
                             ticwrap = new ticketwrap(t.id,t.Tstatus_Id__r.Tstatus_name__c);
                             
                               if(badgeidsmap.containsKey(t.Custom_Barcode__c)){
                                bdge_nd_ticketwrap.put(badgeidsmap.get(t.Custom_Barcode__c),ticwrap);
                               }else if(badgeidsmap.containsKey(t.Badge_ID__c)){
                                bdge_nd_ticketwrap.put(badgeidsmap.get(t.Badge_ID__c),ticwrap);
                               }else if(badgeidsmap.containsKey(t.Scan_Id__c)){
                                bdge_nd_ticketwrap.put(badgeidsmap.get(t.Scan_Id__c),ticwrap);
                               } 
                       
                    }else{
                        ticwrap = new ticketwrap(t.id,true);
                             if(badgeidsmap.containsKey(t.Custom_Barcode__c)){
                                bdge_nd_ticketwrap.put(badgeidsmap.get(t.Custom_Barcode__c),ticwrap);
                               }else if(badgeidsmap.containsKey(t.Badge_ID__c)){
                                bdge_nd_ticketwrap.put(badgeidsmap.get(t.Badge_ID__c),ticwrap);
                               }else if(badgeidsmap.containsKey(t.Scan_Id__c)){
                                bdge_nd_ticketwrap.put(badgeidsmap.get(t.Scan_Id__c),ticwrap);
                               } 
                        
                        }
                      }
                      
                      
                      
             /*******************************************************************/      
             list<Tstatus__c> finlainserttsatus = new list<Tstatus__c>();
             if(tstatus_warp.size()>0){
             Tstatus__c tsstatus;
                 for(wraptstausrec twrap:tstatus_warp){  
                        tsstatus =new Tstatus__c();
                 ticketwrap   wrapticket =  bdge_nd_ticketwrap.get(twrap.badgeid);
                  boolean bl=   wrapticket.tsatusbool ;
                  id tickid =   wrapticket.ticid ;
                    boolean blnew;
                        if(bl == true){
                        tsstatus.Tstatus_name__c = false;
                        blnew = false;
                        }else if(bl == false){
                        tsstatus.Tstatus_name__c = true;
                        blnew = true;
                        }
                   ticwrap = new ticketwrap(tickid ,blnew);     
                   bdge_nd_ticketwrap.put(twrap.badgeid,ticwrap);
                   tsstatus.Ticket__c = tickid ;
                   tsstatus.Device_Name__c = twrap.Device_Name ;
                   tsstatus.Scan_source__c = twrap.Scan_source ;
                   tsstatus.scan_time__c = twrap.scan_time ;
                   
                   finlainserttsatus.add(tsstatus);
                      }
            
             }
          /************************INSERT SCANS*******************************************/
           Map<id,Tstatus__c > tikid_nd_tst=new Map<id,Tstatus__c >();
             if(finlainserttsatus.size()>0){
             system.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$$$'+finlainserttsatus);
              DataBase.saveResult[] svResult = Database.insert(finlainserttsatus,false);
              }
              
              list<ticket__c> ticket_list ;
              if(finlainserttsatus.size()>0){
                  
                     for(Tstatus__c tst:finlainserttsatus){
                          
                         if(tikid_nd_tst.containsKey(tst.Ticket__c)){
                            Tstatus__c tsold =  tikid_nd_tst.get(tst.Ticket__c);
                              if(tst.scan_time__c >= tsold.scan_time__c ){
                                 tikid_nd_tst.put(tst.Ticket__c,tst);
                                }
                           }else if(!tikid_nd_tst.containsKey(tst.Ticket__c)){
                            tikid_nd_tst.put(tst.Ticket__c,tst);
                           }
                     }
               }
               
           if(tikid_nd_tst.size()>0){
            ticket_list =new list<ticket__c>();
               for(Tstatus__c mp:tikid_nd_tst.values()){
                ticket__c tkrec = new ticket__c();
                           tkrec.id =   mp.Ticket__c ;
                           tkrec.Tstatus_Id__c = mp.id;
                       ticket_list.add(tkrec);
               
               }
           }    
                                 
         /************************************update tickets******************************************/
         try{
            if(ticket_list.size()>0){
              DataBase.saveResult[] updticketsResult = Database.update(ticket_list,false);
              }   
          }catch(Exception e){}   
        /***********************UN FORMATED RECORD FILE TO RETURTN********************************************/
        string mailCSVAttachment ='' ;
        try{
          if(failuretstatus_wrap.size()>0){
          mailCSVAttachment = 'Custom barcode'+ ',' + 'Scan DateTime'+ ',' +'scandevise'+ '\n';
            for(wraptstausrec bg:failuretstatus_wrap){     
               mailCSVAttachment += bg.badgeid  + ',' + bg.scan_time + ',' +bg.Device_Name + '\n'; 
           }
         }
         }catch(Exception e){}
        /***************************sending email****************************/
        if(mailCSVAttachment.length()>0){
           OrgWideEmailAddress Org = [select id from OrgWideEmailAddress  where DisplayName = 'supporteventdex'];
            
            Messaging.SingleEmailMessage singleEmail = new Messaging.SingleEmailMessage();
            string [] toAddresses = new string[]{UserInfo.getUserName()};//
            
            singleEmail.setToAddresses(toAddresses);
         //  singleEmail.setToAddresses();
            singleEmail.setOrgWideEmailAddressId(Org.id);
            singleEmail.setSubject('Invalid Format Records');
            singleEmail.setHtmlBody('These Records are in invalid format please correct and upload again');
            
            Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
            blob csvBlob = Blob.valueOf(mailCSVAttachment); //finalstr;
            string csvname= 'Import Scans Failures.csv';
            csvAttc.setFileName(csvname);
            csvAttc.setBody(csvBlob);

            singleEmail.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});

            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { singleEmail }); 
           }
         
        /*********************************************************************/
        PageReference pg=new PageReference('/apex/BLN_CheckinHistoryReport');
        pg.setRedirect(true);
        return pg;        
        }
        else{
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Custom Barcode ,Scan Date and Scan Time are mandatory to map for Import.');
        ApexPages.addMessage(myMsg); 
        return null;
        }
      
     }
     
    public string getformateddate(string x){
     //string x ='10/4/2011 11:59';
     
     system.debug('%%%%%%%%%%%%%%%%datetime'+x);
           string qs;
            if(x.contains('/')){
                 list<string> dtndtime= x.split(' ');
                 list<string> dtlist= dtndtime[0].split('/');
                 list<string> timehhndmm= dtndtime[1].split(':');
                 integer mon = integer.valueof(dtlist[0]);
                 integer dd = integer.valueof(dtlist[1]);
                 integer yy = integer.valueof(dtlist[2]);
                 integer hh = integer.valueof(timehhndmm[0]);
                 integer mm = integer.valueof(timehhndmm[1]);
                       string tcode;
                        if(hh>12){
                          tcode = 'PM';
                          hh=hh-12;
                        }else if((hh == 12 )&& (mm > 0)){
                           tcode = 'PM';
                          
                        }else if(hh <= 12 ){
                           tcode = 'AM';
                        }
                    qs =mon+'/'+dd+'/'+yy+' '+hh+':'+mm+' '+tcode;
                    system.debug('&&&&&&&&&&&&&&&'+qs);
             return qs;
            }else if(x.contains('-')){
                //string x ='2011-4-10 13:46';
                 list<string> dtndtime= x.split(' ');
                 list<string> dtlist= dtndtime[0].split('-');
                 list<string> timehhndmm= dtndtime[1].split(':');
                 integer yy = integer.valueof(dtlist[0]);
                 integer mon = integer.valueof(dtlist[1]);
                 integer dd = integer.valueof(dtlist[2]);
                 integer hh = integer.valueof(timehhndmm[0]);
                 integer mm = integer.valueof(timehhndmm[1]);
                       string tcode;
                        if(hh>12){
                          tcode = 'PM';
                          hh=hh-12;
                        }else if((hh == 12 )&& (mm > 0)){
                           tcode = 'PM';
                        }else if(hh <= 12 ){
                           tcode = 'AM';
                        }
                    qs =mon+'/'+dd+'/'+yy+' '+hh+':'+mm+' '+tcode;
            
                 return qs;
                    
               }else if(x.contains('.')){
                //2003.03.18 23:50:44
                system.debug('$$$$$$$$$$$$$$$$$$$$$$$testtime'+x);
                 list<string> dtndtime= x.split(' ');
                 list<string> dtlist= dtndtime[0].split('\\.');
                 list<string> timehhndmm= dtndtime[1].split(':');
                 integer yy = integer.valueof(dtlist[0]);
                 integer mon = integer.valueof(dtlist[1]);
                 integer dd = integer.valueof(dtlist[2]);
                 integer hh = integer.valueof(timehhndmm[0]);
                 integer mm = integer.valueof(timehhndmm[1]);
                       string tcode;
                        if(hh>12){
                          tcode = 'PM';
                          hh=hh-12;
                        }else if((hh == 12 )&& (mm > 0)){
                           tcode = 'PM';
                        }else if(hh <= 12 ){
                           tcode = 'AM';
                        }
                    qs =mon+'/'+dd+'/'+yy+' '+hh+':'+mm+' '+tcode;
                 system.debug('$$$$qs'+qs);
                 return qs;
                    }
            return null;
    
    } 
/*********wraper class*******************************/
global class wraptstausrec implements Comparable{//
global string Device_Name{get;set;}
global string Scan_source{get;set;}
global Datetime scan_time{get;set;}
global string badgeid{get;set;}
global wraptstausrec(string Device_Name1,string Scan_source1,datetime scan_time1,string badgeid1){

Device_Name = Device_Name1;
Scan_source = Scan_source1;
scan_time = scan_time1;
badgeid = badgeid1;
}
 global Integer compareTo(Object compareTo){
 
         wraptstausrec  compareTomember = (wraptstausrec )compareTo;
            Integer returnValue = 0;
             if (scan_time > compareTomember.scan_time) {
                   returnValue = 1;
            } else if (scan_time < compareTomember.scan_time) {
                   returnValue = -1;
            }
 
             return returnValue;       
           
        }  
}
/**************************************************/
public class ticketwrap{
public id ticid{get;set;}
public boolean tsatusbool{get;set;}
public ticketwrap(id ticketid,boolean bol){
ticid = ticketid;
tsatusbool = bol;
}

}

/**************************************************/
  public static String blobToString(Blob input, String inCharset){
        String hex = EncodingUtil.convertToHex(input);
        System.assertEquals(0, hex.length() & 1);
        final Integer bytesCount = hex.length() >> 1;
        String[] bytes = new String[bytesCount];
        for(Integer i = 0; i < bytesCount; ++i)
            bytes[i] =  hex.mid(i << 1, 2);
        return EncodingUtil.urlDecode('%' + String.join(bytes, '%'), inCharset);
    }    

/****************************************************/
public PageReference exportToCSV()
        {
                PageReference pageRef= new PageReference('/apex/BLN_ScansImportTemplate');
                pageRef.setredirect(false);
                return pageRef;
        }

}