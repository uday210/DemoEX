public without sharing class BLN_ParticipantRevisitReport_BAL {
/**************************************************************
Author: Mythily
Date:   09 MAR 2016
Purpose : Showing all participants who were Revisited
***************************************************************/
    Public List<Tstatus__c> Tstatus {get ; set ;}
    Public List<Tstatus__c> TotalScans {get ; set ;}
    Public BLN_TStatus_DAO TstatusDao {get ; set ;}
    public List<RevistInner> RevistInnerlist {get ; set ;}
    Public List<EachdayScans> EachdayscansList {get ; set ;}
    public List<Totalinner> TotalLists {get ; set ;}
    
    public  List<Totalinner> RevistedParticipants(id eventid,LIST<Date> Eventdates){
        Tstatus = new List<Tstatus__c>();
        TotalLists = new List<Totalinner>();
        TotalScans = new  List<Tstatus__c>();
        TstatusDao = new BLN_TStatus_DAO ();
        EachdayscansList = new List<EachdayScans>();
        RevistInnerlist = new List<RevistInner> ();
        
        //End Of Calculating All dates of an Event
                
        Tstatus = TstatusDao.EventTstatuses(eventid);
        system.debug('::::::::::Tstatus:::::::::::::;'+Tstatus);
        //Tis for Repeats All Tstaus records of the event
        //And will catch the records who checked repeatedly for the next day of the event
        integer i=0;
        SET<string> Scanstring = new SET<string> ();
        SET<string> ScanstringRevisit = new SET<string> ();
        List<string> ScanstringRevisitList = new List<string> ();
         
        if(Eventdates != null){
            for(Date dt : Eventdates){
                set<string> duplicatestringsset = new Set<string>();
                List<Tstatus__c> Tscans = new List<Tstatus__c>();
                for(Tstatus__c TS: Tstatus){
                    if(dt == TS.scan_time__c.date()){
                      string st = TS.Ticket__c;
                      //TotalScans.add(TS);
                       system.debug('           Mythily              '+st);
                         if(i==0){//This will excute only at first time
                              Scanstring.add(st);//First time it adds all first day scans
                              system.debug('Mythily'+st);
                              string duplicatestring = TS.Ticket__c+'-'+dt;
                              duplicatestringsset.add(duplicatestring);
                              
                          }
                          
                          else{//From Second day onwards it will excute
                          system.debug('           Mythily              '+st);
                               if(Scanstring.contains(TS.Ticket__c)){
                               //comparing id is there in firstday set of ids                               
                                          if(!duplicatestringsset.contains(TS.Ticket__c+'-'+dt)){
                                              system.debug('           Mythily              '+ScanstringRevisit);
                                              Tscans.add(TS);
                                              //RevistInnerlist.add(new RevistInner(dt,TS)); 
                                          
                                      }  
                               }else{
                                   Scanstring.add(st);
                                   //If Revisited on the sameday here we are excluding them
                                   string duplicatestring = TS.Ticket__c+'-'+dt;
                                   duplicatestringsset.add(duplicatestring);
                                   } 
                          }       
                         
                    }    
                }
                system.debug('           Mythily              '+Tscans);
                if(Tscans.size()>0){
                    RevistInnerlist.add(new RevistInner(dt,Tscans));  
                  }
                  if(TotalScans.size()>0){
                     EachdayscansList.add(new EachdayScans(dt,TotalScans));
                  }
              system.debug('           Mythily              '+RevistInnerlist);
              i++;
        }
        Tstatus = new List<Tstatus__c>();
        }
        TotalLists.add(new Totalinner(RevistInnerlist,EachdayscansList));
        return TotalLists;
    }
    
    
    //INNER CLASS FOR REVSIT PARTICIPANTS
    public class RevistInner{
    public date scandate {get ; set ;}
    public List<Tstatus__c> TstatusRecs {get ; set ;}
    public Tstatus__c Tstatusrevis {get ; set ;}
    public RevistInner(date scandate,List<Tstatus__c> TstatusRecs ){
        this.scandate = scandate;
        this.TstatusRecs = TstatusRecs ;
    }
    
    
    }
    //This Inner is for EveryDay Schans Report
    public class EachdayScans{
    public date Tscandate {get ; set ;}
    public List<Tstatus__c> Totalscans {get ; set ;}
    
    public EachdayScans(date Tscandate,List<Tstatus__c> Totalscans ){
        this.Tscandate = Tscandate;
        this.Totalscans = Totalscans ;
    }
    
    }
    public class Totalinner{
    public List<RevistInner> RevisitedList {get ; set ;}
    Public List<EachdayScans> EachdayList {get ; set ;}
    public Totalinner(List<RevistInner> RevisitedList,List<EachdayScans> EachdayList ){
        this.RevisitedList = RevisitedList;
        this.EachdayList = EachdayList;
    
    
    }
    
    }

}