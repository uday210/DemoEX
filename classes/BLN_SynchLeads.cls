/******************************************************
*   Author                  : Rajendra Y
*   Date                    : 05/02/2016 
*   Purpose                 : This is Web Service class for Insert Offline Leads and Update of line Leads.
********************************************************/

@RestResource(urlMapping='/BLN_SynchLeads/*')
global without sharing class BLN_SynchLeads {
 Static innerledas inlds = new innerledas();
@httpPost
global static innerledas doPost(){
RestRequest req = RestContext.request;
RestResponse res = RestContext.response;
    
     string Reqblobbody = req.requestBody.toString();
     
     String loginUserId;
     String eventId; 
     String luCompId ;
     DateTime sTime ;
      
     leads leds = new leads();
     leds = (leads) JSON.deserialize(Reqblobbody, leads.class);
     loginUserId = req.params.get('loginUserId');
     eventId = req.params.get('eventId');
     luCompId = req.params.get('luCompId');
     string dt=req.params.get('sTime');
     BLN_timeConToEvzoneCon timezonecl=new BLN_timeConToEvzoneCon();
    User u = new User();
    try{
      u=[select id,name,TimeZoneSidKey,LocaleSidKey,email from User where id=:UserInfo.getUserId()];
    }catch(exception er){}   

    sTime = timezonecl.getDateBasedOnEventTimeZone(dt, u.TimeZoneSidKey,'GMT'); 
      
     List<String> BarcodeIds = new List<String>();
     lisT<Lead_Scan__c> lscanlistupdate = new list<Lead_Scan__c>();
   
     BLN_Ticket_DAO tkdsy = new BLN_Ticket_DAO();
     BLN_LeadScan_DAO led=new BLN_LeadScan_DAO();
     map<string,string> mapwithtime = new map<string,string>();
     string leadtime='';
     for(BarcodeOflineLeads str:leds.barCodes){
     BarcodeIds.add(str.id);
     string idlower=string.valueOf(str.id).toLowerCase();
     System.debug('KKKKK11::'+idlower);
     mapwithtime.put(idlower,str.scanTime);
     System.debug('KKKKK22::'+mapwithtime);
     leadtime+= string.valueOf(str.id).toLowerCase()+',';// str.id+',';
   
   }
   system.debug('leadtime====='+leadtime);
   list<ticket__c> tc = new list<ticket__c>();
   lisT<Lead_Scan__c> lscanlist = new list<Lead_Scan__c>();
   lisT<Lead_Scan__c> lscanlistall = new list<Lead_Scan__c>();
   MAP<string,Lead_Scan__c> checkeleadexc=new  MAP<string,Lead_Scan__c>();
   lscanlistall=led.allleads(eventId,loginUserId); // fech all leadscan recodrs based on eventid and loginuserid
    Map<id,Lead_Scan__c> alleadsmap = new Map<id,Lead_Scan__c>();
   if(BarcodeIds.size()>0){
   tc=tkdsy.getcustombarcodesyc(BarcodeIds,eventId); // fech all tickes based on custom barcodes or badge ids
   }
   system.debug('tc======'+tc);
   system.debug('lscanlistall======'+lscanlistall);
   for(Lead_Scan__c lec:lscanlistall){
   checkeleadexc.put(lec.BLN_TKT_profile__c,lec);
   alleadsmap.put(lec.id,lec);
   
   }
   list<Ticket__c> lcscandup= new list<Ticket__c>();
   list<Ticket__c> lcscaninsert= new list<Ticket__c>();
   // start inserting list of Lead scan object based on custom barcodes or badge ids
   string ledscantimes='';
   BLN_Events_DAO evndao = new BLN_Events_DAO();
   BLN_Event__c ev = new BLN_Event__c();
   ev = evndao.getEventtimezone(eventId);
    system.debug('ev===='+ev);
   list<datetime>scantimeList=  new list<datetime>();
   SET<String> extIds = new SET<String>();

   inlds.leadsList = new List<Lead_Scan__c>();
   if(tc.size()>0){
   for(ticket__c tct:tc){
        if(tct.Custom_Barcode__c!=null)
            extIds.add(tct.Custom_Barcode__c.toLowerCase());
        if(tct.Badge_ID__c!=null)
            extIds.add(String.valueOf(tct.Badge_ID__c).toLowerCase()); 
        if (tct.Scan_Id__c!=null)
            extIds.add(tct.Scan_Id__c); 

       if(checkeleadexc.keySet().contains(tct.tkt_profile__c)){
           inlds.leadsList.add(checkeleadexc.get(tct.tkt_profile__c));
           lcscandup.add(tct); // this list contains already existing barcode if their are scaned 2nd time those recodes are added in this list
        } else {
        lcscaninsert.add(tct); // this list contains new leadscan recodes based on bardcode or badge ids 
       }
       // lscanlist.add(lscan);
       system.debug(tct.Custom_Barcode__c +'rajj'+tct.Badge_ID__c+'enddd'+tct.Scan_Id__c);
       if(tct.Custom_Barcode__c!=null && leadtime.contains(string.valueOf(tct.Custom_Barcode__c).toLowerCase())){
        string lstime=string.valueOf(tct.Custom_Barcode__c).toLowerCase();
        System.debug('KKKKK33::'+lstime);
        ledscantimes=mapwithtime.get(lstime);
        System.debug('KKKKK44::'+ledscantimes);
        //ledscantimes=mapwithtime.get(tct.Custom_Barcode__c);
       }else if(tct.Badge_ID__c!=null && leadtime.contains(string.valueOf(tct.Badge_ID__c).toLowerCase())){
           string lstime=string.valueOf(tct.Badge_ID__c).toLowerCase();
           ledscantimes=mapwithtime.get(lstime);
           //ledscantimes=mapwithtime.get(tct.Badge_ID__c);
       }else if(tct.Scan_Id__c!=null && leadtime.contains(string.valueOf(tct.Scan_Id__c).toLowerCase())){
           string lstime=string.valueOf(tct.Scan_Id__c).toLowerCase();
           ledscantimes=mapwithtime.get(lstime);
           //ledscantimes=mapwithtime.get(tct.Scan_Id__c);
       }
       system.debug('ledscantimes===='+ledscantimes);
        //datetime sTimeled=timezonecl.getDateBasedOnEventTimeZone(ledscantimes,'GMT',ev.Time_Zone__c);
         datetime sTimeled = timezonecl.getDateBasedOnEventTimeZone(dt,u.TimeZoneSidKey,'GMT');
        //datetime sTimeled = timezonecl.getEventTimeZone(dt, 'GMT',u.TimeZoneSidKey); 
        scantimeList.add(sTimeled);
        }
        }
        system.debug('lcscaninsert======'+lcscaninsert);
            BLN_LeadRetrieval_BAL bl=new BLN_LeadRetrieval_BAL();
         DataBase.saveResult[] saveres = bl.insertLead(lcscaninsert,loginUserId,eventId,luCompId ,scantimeList);  
       
       
            
            set<Id> ledsIds = new set<Id>(); 
    SET<String> leadsStr = new SET<String>();
    /* for(DataBase.saveResult svResult :saveres){
            if(svResult.issuccess()){
             ledsIds.add(svResult.getId());
            }
     }*/
    inlds.failedBadges = new List<String>();
    for(String barids : BarcodeIds ){
       if(!extIds.contains(barids.toLowerCase())){
          inlds.failedBadges.add(barids);
       }
           }
  System.debug(' HHHHHHHHHHHHHHHHHHHHHHHHH '+inlds.failedBadges);
  
         
             
    for (Integer tp = 0; tp < lcscaninsert.size(); tp++) {
      if (saveres[tp].issuccess()) {
        ledsIds.add(saveres[tp].getId());
      } else {
        if (lcscaninsert[tp].Custom_Barcode__c != null)
          lcscaninsert[tp].Custom_Barcode__c = lcscaninsert[tp].Custom_Barcode__c.toLowerCase();
        if (lcscaninsert[tp].Badge_ID__c != null)
          lcscaninsert[tp].Badge_ID__c = string.valueOf(lcscaninsert[tp].Badge_ID__c).toLowerCase();
        System.debug('HHHHHHHHHHHHHH ' + lcscaninsert[tp].Custom_Barcode__c + '  JJJJJ ' + lcscaninsert[tp].Badge_ID__c + '  ' + lcscaninsert[tp].Scan_Id__c);
        System.debug('KKKKKKKK ' + mapwithtime.keyset());

        if (!mapwithtime.keyset().contains(lcscaninsert[tp].Custom_Barcode__c))
          inlds.failedBadges.add(lcscaninsert[tp].Custom_Barcode__c);
        else if (!mapwithtime.keyset().contains(lcscaninsert[tp].Scan_Id__c))
          inlds.failedBadges.add(lcscaninsert[tp].Scan_Id__c);
        else if (!mapwithtime.keyset().contains(lcscaninsert[tp].Badge_ID__c))
          inlds.failedBadges.add(lcscaninsert[tp].Badge_ID__c);
      }
    }

   SET<id> lids = new SET<id>();
    List<Lead_Scan__c> lsUpdate = new List<Lead_Scan__c>();
    // start update list of leadscan objects
          for(OfflineLedsUpdate lc:leds.leadScan){
            
             Lead_Scan__c lec = new Lead_Scan__c();
            
             lec = alleadsmap.get(lc.id);
             if(null!=lec){
             lec.First_Name__c=lc.firstName;
             lec.Last_Name__c=lc.lastName;
             lec.notes__c=lc.notes;
              if(lc.rating!=null && lc.rating!=''){
             integer rat =integer.valueof(lc.rating);
             lec.Rating__c=rat;
             }
             
             if(!lids.contains(lec.id)){
        lsUpdate.add(lec);
               lids.add(lec.id);
                    }
             }
          }
    Database.SaveResult[] udateledRes = Database.Update(lsUpdate, false);
    for (Database.saveResult upres : udateledRes ) {
      if (upres.issuccess()) {
        ledsIds.add(upres.getId());
      }
             }
              list<Lead_Scan__c> listleadscans = new list<Lead_Scan__c>();
              listleadscans=led.leadRecords(ledsIds);
           inlds.leadsList.AddAll(listleadscans);
          BLN_ResponseMsg msg=new BLN_ResponseMsg();
        if(inlds.leadsList.size()>0){
         msg.ldvalueAssign('Message','You have successfully updated data !',TRUE); 
         
         }else{
         
         msg.ldvalueAssign('Message','No Data Found!',FALSE); 
         
         
         }
         inlds.Msg=msg;
         
        return inlds;
        
   }
   
global class leads{
  public list<BarcodeOflineLeads> barCodes{get;set;}
  public list<OfflineLedsUpdate> leadScan{get;set;}
}
global class BarcodeOflineLeads{
public string id;
public string scanTime;
}
 global class OfflineLedsUpdate{
 
 public string id;
 public string firstName;
 public string lastName;
 public string notes;
 public string rating;
 
 } 
global class innerledas{
 public BLN_ResponseMsg Msg{get;set;}
 public list<Lead_Scan__c> leadsList {get;set;}
 public List<String> failedBadges{get;set;}
}
 
}