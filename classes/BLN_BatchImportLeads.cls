global without sharing class BLN_BatchImportLeads implements Database.batchable < List < String >> , Database.Stateful {
   // start of global variable declaration
    List < List < String >> allFields;
    LIST < Imortleadscon.header > gridrows;

    String mailCSVAttachment;
    Integer K = 0;
    datetime sTimeled;
    String str;
    string tzone;
    public bln_Event__c evs { get;set;}
     public integer recimported{get;set;}
     public integer reccreated{get;set;}
     public integer recfailed{get;set;}
    public list < string > badgeIdList {set;get;}
    public set < string > badgeset {get;set;}
    public list < datetime > scantimeList {set;get;}
    public lisT < Lead_Scan__c > lscanlistall { get;set;}
    public string selectedeventid {get;set;}
    public string loginusergnid {get;set;}
    public string compid {get;set;}
    public map<string,wrapBadgeandtime> badgewithtime_map{get;set;}
    public set<string> alltypebadgeids{get;set;}
    public list < String > devicelist {get;set;}
    public string csvAsString{get;set;}
    BLN_timeConToEvzoneCon timezonecl = new BLN_timeConToEvzoneCon();
   // end of global variable declaration
   //start of construtor method
    public BLN_BatchImportLeads(List < List < String >> allFields, LIST < Imortleadscon.header > gridrows, bln_Event__c evs1, lisT < Lead_Scan__c > lscanlistall1, string loginusergnid, string compid,string csvAsString1) {
        recimported=reccreated=recfailed=0;
        this.allFields = allFields;
        //this.K = 0;
        this.gridrows = gridrows;
        evs = new bln_Event__c();
        this.evs = evs1;
        lscanlistall = new lisT < Lead_Scan__c > ();
        this.lscanlistall = lscanlistall1;
        this.loginusergnid = loginusergnid;
        this.compid = compid;
        csvAsString=csvAsString1;
        mailCSVAttachment ='Error Message';

        for (integer j = 0; j < gridrows.size(); j++) {
                mailCSVAttachment = mailCSVAttachment + ',' + gridrows[j].csvheader;
            }
        mailCSVAttachment = mailCSVAttachment + '\n';
        
        badgewithtime_map = new map<string,wrapBadgeandtime>();
         alltypebadgeids = new set<string>();
       BLN_Ticket_DAO tkdsyt = new BLN_Ticket_DAO();
       for(ticket__c allBooktickets:tkdsyt.getAllbadges(evs.id)){
          if(allBooktickets.Badge_ID__c !=NULL)
          alltypebadgeids.add(string.valueof(allBooktickets.Badge_ID__c).toUpperCase());
          if(allBooktickets.Scan_Id__c !=NULL)
          alltypebadgeids.add(string.valueof(allBooktickets.Scan_Id__c).toUpperCase());
          if(allBooktickets.Custom_Barcode__c  !=NULL)
          alltypebadgeids.add(string.valueof(allBooktickets.Custom_Barcode__c).toUpperCase());
        }
    }
 // end of constructor method
//start of batch start method
    global Iterable < List < String >> start(Database.batchableContext batchableContext) {
        return new BLN_BatchListIterator(allFields);

    }
//end of batch start method
// start of execute method
    global void execute(Database.BatchableContext batchableContext, List < List < String >> scope) {

        badgeIdList = new list < string > ();
        scantimeList = new list < datetime > ();
        devicelist = new list < string > ();
        string stime;
        String sDate;
        String fdate;
        string barcode;
        string stimeempt;
        string sdateempt;
        badgeset = new set < string > ();
        integer duplicateRecords = 0;
        for (integer i = 0; i < scope.size(); i++) {
         recimported++;
            barcode = '';
            stimeempt = '';
            sdateempt = '';
            boolean badgeboolen = false;
            List < String > eachrowrecord = scope[i];
            for (integer j = 0; j < gridrows.size(); j++) {
                
                if (gridrows[j].field != '') {
                    if (gridrows[j].field == 'Custom_Barcode__c') {
                        barcode = eachrowrecord[j].toUpperCase();
                        if (eachrowrecord[j] != null && eachrowrecord[j] != '')
                            badgeIdList.add(eachrowrecord[j].toUpperCase());
                        badgeset.add(eachrowrecord[j].toUpperCase());
                    } else {
                        badgeboolen = true;
                    }
                    if (gridrows[j].field == 'Scan_Date__c') {
                        sdateempt = eachrowrecord[j];
                        // system.debug('eachrowrecord[j]======'+eachrowrecord[j]);
                        if (eachrowrecord[j] != null && eachrowrecord[j] != '') {
                            try {

                                datetime dd = Date.parse(eachrowrecord[j].trim());
                                sDate = dd.format('MM/dd/yyyy');
                                
                            } catch (Exception e) {

                               
                            }
                            
                            if (sDate == null && sDate == '') {
                                try {
                                    // valueof works in the case of 1983-10-11
                                    system.debug('saaaaaaaaaaaaaaaa');
                                    // datetime sDatee = eachrowrecord[j].trim();
                                    list < string > dtndtime = eachrowrecord[j].split(' ');
                                    dtndtime[0].Replace('-', '/');
                                    list < string > dtlist = dtndtime[0].split('/');

                                    integer yy = integer.valueof(dtlist[0]);
                                    integer mon = integer.valueof(dtlist[1]);
                                    integer dd = integer.valueof(dtlist[2]);

                                    Datetime d = Datetime.newInstance(yy, mon, dd);


                                    sDate = d.format('MM/dd/yyyy');
                                } catch (Exception e) {

                                   
                                }
                            }


                        } else {
                            sDate = '';
                        }
                    }
                    if (gridrows[j].field == 'Scan_Time__c') {
                        stimeempt = eachrowrecord[j];
                        if (eachrowrecord[j] != null && eachrowrecord[j] != '') {
                            list < string > dtndtime = eachrowrecord[j].split(' ');


                            try{
                            list < string > timehhndmm = dtndtime[0].split(':');

                            integer hh = integer.valueof(timehhndmm[0]);
                            integer mm = integer.valueof(timehhndmm[1]);
                            string tcode;
                            if (hh > 12) {
                                tcode = 'PM';
                                hh = hh - 12;
                            } else if ((hh == 12) && (mm > 0)) {
                                tcode = 'PM';
                            } else if (hh <= 12) {
                                tcode = 'AM';
                            }

                            stime = hh + ':' + mm + ' ' + tcode;
                            }catch(Exception e){stime = '';}
                            //system.debug('stime========='+stime);
                        } else {
                            stime = '';
                        }
                    }
                }


            }



            if (sdate != null && sdate != '' && stime != null && stime != '') {
                fdate = sdate + ' ' + stime;
                
            } else {
                fdate = '';
            }
            try {
                if (fdate != null && fdate != '') {
                    sTimeled = timezonecl.getDateBasedOnEventTimeZone(fdate, 'GMT', evs.Time_Zone__c);
                    
                    scantimeList.add(sTimeled);
                } else {
                    scantimeList.add(Null);
                    mailCSVAttachment += 'Not a valid Scan Date Time'+ ',' + barcode + ',' + sdateempt + ',' + stimeempt + '\n';

                }
            } catch (exception e) {
               
                k++;
                scantimeList.add(Null);
                mailCSVAttachment += 'Not a valid Scan Date Time'+ ',' + barcode + ',' + sdateempt + ',' + stimeempt + '\n';
               
            }
        
         
         if(!badgewithtime_map.containskey(barcode.toUpperCase())){
             badgewithtime_map.put(barcode.toUpperCase() ,new wrapBadgeandtime(sdateempt ,stimeempt ));
             
         }else{
             mailCSVAttachment += 'Duplicate Lead'+ ',' + barcode + ',' + sdateempt + ',' + stimeempt + '\n';
             duplicateRecords++;
            recfailed++;
         }

        }
        set < id > leadsetid = new set < id > ();
        for (Lead_Scan__c l: lscanlistall) {

            leadsetid.add(l.BLN_TKT_profile__c);
        }

        BLN_Ticket_DAO tkdsy = new BLN_Ticket_DAO();
        list < ticket__c > tc = new list < ticket__c > ();
        list < Ticket__c > newlcsinsert = new list < Ticket__c > ();
        if (badgeIdList.size() > 0) {
            tc = tkdsy.getcustombarcodesyc(badgeIdList, evs.id); // fech all tickes based on custom barcodes or badge ids
        }
        
         set<string> unknownBadges=new set<string>();
        for(string blist:badgeIdList){
            if(!alltypebadgeids.contains(blist.toUpperCase())){
              unknownBadges.add(blist);
            }
        }
        if(unknownBadges.size()>0){
        for(string ub:unknownBadges){       
        mailCSVAttachment += 'Invalid Custom Barcode'+ ',' + ub+ ',' + badgewithtime_map.get(ub.toUpperCase()).scDate+ ',' + badgewithtime_map.get(ub.toUpperCase()).scTime+ '\n';
         recfailed++;
         }
        }
       
        
        integer i = 0;
       if(tc.size()>0){
        for (ticket__c t: tc) {
            if (leadsetid.contains(t.tkt_profile__c)) {
            string duplead='';
            try{
                duplead=(badgewithtime_map.containskey(string.valueof(t.Custom_Barcode__c).toUpperCase() ) ? t.Custom_Barcode__c : (badgewithtime_map.containskey(string.valueof(t.Badge_ID__c).toUpperCase() )?t.Badge_ID__c :(badgewithtime_map.containskey(string.valueof(t.Scan_Id__c).toUpperCase() )?t.Scan_Id__c:'noresult')));
             }catch(exception e){
                 duplead='noresult';
             }
                 if(!duplead.contains('noresult'))
                  mailCSVAttachment += 'Duplicate Lead'+ ',' +(badgewithtime_map.containskey(string.valueof(t.Custom_Barcode__c).toUpperCase() ) ? t.Custom_Barcode__c : (badgewithtime_map.containskey(string.valueof(t.Badge_ID__c).toUpperCase() )?t.Badge_ID__c :(badgewithtime_map.containskey(string.valueof(t.Scan_Id__c).toUpperCase() )?t.Scan_Id__c:'noresult'))) + ',' +badgewithtime_map.get(badgewithtime_map.containskey(string.valueof(t.Custom_Barcode__c).toUpperCase() ) ?string.valueof(t.Custom_Barcode__c).toUpperCase() : (badgewithtime_map.containskey(string.valueof(t.Badge_ID__c).toUpperCase() )?string.valueof(t.Badge_ID__c).toUpperCase() :(badgewithtime_map.containskey(string.valueof(t.Scan_Id__c).toUpperCase() )?string.valueof(t.Scan_Id__c).toUpperCase():'noresult'))).scDate + ',' + badgewithtime_map.get(badgewithtime_map.containskey(string.valueof(t.Custom_Barcode__c).toUpperCase() ) ? string.valueof(t.Custom_Barcode__c).toUpperCase() : (badgewithtime_map.containskey(string.valueof(t.Badge_ID__c).toUpperCase() )?string.valueof(t.Badge_ID__c).toUpperCase() :(badgewithtime_map.containskey(string.valueof(t.Scan_Id__c).toUpperCase() )?string.valueof(t.Scan_Id__c).toUpperCase():'noresult'))).scTime+ '\n';
                duplicateRecords++;
                recfailed++;
            } else {

                Lead_Scan__c ce = new Lead_Scan__c();
                ce.City__c = t.Tkt_profile__r.Work_Address__r.City__c;
                ce.BLN_Country__c = t.Tkt_profile__r.Work_Address__r.Country__c;
                ce.BLN_State__c = t.Tkt_profile__r.Work_Address__r.State__c;
                ce.Street1__c = t.Tkt_profile__r.Work_Address__r.Address1__c;
                ce.Street2__c = t.Tkt_profile__r.Work_Address__r.Address2__c;
                ce.Work_Phone__c = t.Tkt_profile__r.Work_Phone__c;
                ce.Zip__c = t.Tkt_profile__r.Work_Address__r.Zipcode__c;
                ce.Cell_Phone__c = t.Tkt_profile__r.Mobile__c;
                ce.Lead_Email__c = t.Tkt_profile__r.Email__c;
                ce.BLN_TKT_profile__c = t.Tkt_profile__c;
                leadsetid.add(t.tkt_profile__c);
                ce.LeadSource__c = 'Import';
                if (evs.id != null)
                    ce.Event__c = evs.id;
                if (t.Tkt_profile__r.TKT_Company__c != null)
                    ce.Company__c = t.Tkt_profile__r.TKT_Company__c;

                ce.First_Name__c = t.Tkt_profile__r.First_Name__c;
                ce.Last_Name__c = t.Tkt_profile__r.Last_Name__c;
                ce.Prefix__c = t.Tkt_profile__r.Prefix__c;
                ce.Home_Phone__c = t.Tkt_profile__r.Home_Phone__c;

                if (compid != null && compid != '')
                    ce.Scanner_Company__c = compid;
                if (loginusergnid != null && loginusergnid != '')
                    ce.Scanner_User__c = loginusergnid;
                if (scantimeList.size() > 0) {

                    ce.Scan_Time__c = scantimeList[i];
                }
                ce.Suffix__c = t.Tkt_profile__r.Suffix__c;
                ce.User_pic__c = t.Tkt_profile__r.User_pic__c;

                if (t.Tkt_profile__r.TKT_Job_Title__c != null & t.Tkt_profile__r.TKT_Job_Title__c != '')
                    ce.Title__c = t.Tkt_profile__r.TKT_Job_Title__c;
                if (scantimeList[i] != null) {
                    DataBase.saveResult saveres = DataBase.insert(ce, false);

                    if (!saveres.IsSuccess()) {
                       recfailed++;
                        k++;
                      /*  if (t.Custom_Barcode__c != null && badgeset.contains(t.Custom_Barcode__c)) {
                            mailCSVAttachment += t.Custom_Barcode__c + ',' + scantimeList[i] + '\n';
                        } else if (t.Badge_ID__c != null && badgeset.contains(t.Badge_ID__c)) {
                            mailCSVAttachment += t.Badge_ID__c + ',' + scantimeList[i] + '\n';
                        } else if (t.Scan_Id__c != null && badgeset.contains(t.Scan_Id__c)) {
                            mailCSVAttachment += t.Scan_Id__c + ',' + scantimeList[i] + '\n';
                        }*/

                    }else{
                      reccreated++;
                    }
                } else {
                    k++;

                     recfailed++;
                }


            }
            i++;
        }
     }


    }
// end of execute method
//start of Batch Finsh Method    
    global void finish(Database.BatchableContext batchableContext) {
       
        try {
             EmailTemplate E = new EmailTemplate();    
                E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'Import Attendees Summary']; 
                  String emailMessage = E.HtmlValue;
                 emailMessage =emailMessage.replace('{!recimported}',String.valueOf(recimported)); 
                 emailMessage =emailMessage.replace('{!reccreated}',String.valueOf(reccreated)); 
                 emailMessage =emailMessage.replace('{!recfailed}',String.valueOf(recfailed));
                 emailMessage =emailMessage.replace('{!EventName}',evs.name);
                 emailMessage =emailMessage.replace('{!filename}',csvAsString);

                string[] toAddresses = new string[] {
                    UserInfo.getUserName()
                };


        BLN_App_Settings_DAO bas = new BLN_App_Settings_DAO();
        String sendemailfrom = bas.Sendemailfrom();     
        string Fromemail = ''; 
        OrgWideEmailAddress[] owea = [select Id,Address from OrgWideEmailAddress where DisplayName = 'supporteventdex'];
        if(sendemailfrom == 'PostMarkApp') {
        Fromemail = owea.get(0).Address;
         Bln_SendEmailPost.Emailfrombacthclass(Fromemail,toAddresses,'Import Leads for event : '+evs.name,emailMessage,'Import Leads Failures.csv',mailCSVAttachment,'application/json');
        }else{
         Fromemail = owea.get(0).Id;
           Bln_SendEmailPost.EmailfromsalesforceBatch(Fromemail,toAddresses,'Import Leads for event : '+evs.name,emailMessage ,'Import Leads Failures.csv',mailCSVAttachment,'text/csv');
        }  

        } catch (Exception e) {}


    }
 //  End of Batch Finish Method
 // start of wraper class   
     public class wrapBadgeandtime{
     public string scDate{get;set;}
     public string scTime{get;set;}
       public wrapBadgeandtime(string sdate,string stime){
       this.scDate = sdate;
       this.scTime = stime;
       }
     }   
 // end of wraper class
}