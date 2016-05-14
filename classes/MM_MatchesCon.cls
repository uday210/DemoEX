public without sharing class MM_MatchesCon {
  
public string comments{get;set;}
public string schedulestartTime{get;set;}
public string scheduleendTime{get;set;}
public string scheduledate{get;set;}
public boolean vieProfileBool{get;set;}
public AttendeeSummary__c vewProfileEAM {get;set;}
public boolean displaySchedule { get; set; }
public String globalsearch { get; set; }
public String selectedEvent { get; set; }
public string keyword{get;set;}
public string  Name{get;set;}
public string NAICSCodes1{get;set;}
public string NAICSCodes2{get;set;}
public string NAICSCodes3{get;set;}

public string Commodity1{get;set;}
public string Commodity2{get;set;}
public string Commodity3{get;set;}
public string Commodity4{get;set;}
public string Commodity5{get;set;}
public string Commodity6{get;set;}
public string Commodity7{get;set;}
public string Commodity8{get;set;}
public string Commodity9{get;set;}

public string[] PrimaryIndustry{get;set;}
public string EvenId{get;set;}
public List<selectOption> options {get;set;}
public event__c eventtimedetails {get;set;}
public List<string> FinalDayoneTimings{get;set;}
public List<string> FinalDaytwoTimings{get;set;}
public string dayone{get;set;}
public string daytwo{get;set;}
public  SET<string> boothadmins{get;set;}
public List<AttendeeSummary__c> leftsideList{get;set;}
public List<AttendeeSummary__c> righttsideList{get;set;}
public List<EventSchedule__c> eventShedules {get;set;}
public string selectedEmail {get;set;}
public List<AttendeeSummary__c> upes {get;set;} 
public  List<SelectOption> options1{get;set;}
public string seeQuery {get;set;}
public string scheduleddays1{get;set;} 
public string scheduleddays2{get;set;} 
public MAP<string,EventSchedule__c> mapone {get;set;} 
public MAP<string,EventSchedule__c> maptwo {get;set;} 
public boolean displayScheduleerror{get; set;}
public AttendeeSummary__c exbitorSummary{get;set;}
public MAP<string,id> mapEmailwithUpeId{get;set;}
public MAP<string,User_Profile_Event__c> mapEmailwithUpeId1{get;set;}
 public list<Attachment> attchments {get; set;}
 public List<Profile_Settings__c> Psettings  {get ; set ;}
 public list<Tags__c> tagslist {get; set ;}
 public string attendeealias {get ; set ;}
 public string exhibitoralias {get ; set ;}

 public MM_MatchesCon(){
 attendeealias ='';
 exhibitoralias ='';
   Cookie k = ApexPages.currentPage().getCookies().get('counter');
   selectedEvent= k.getValue();

 displayScheduleError=false;
  PrimaryIndustry = new string[]{};
  List<string> events = new List<string>();
  attchments = new List<Attachment>();
   options = new List<selectOption>();
   for(User_Profile_Event__c upe: [select id,  EV_id__c,EV_id__r.id, EV_id__r.EV_Title__c,EV_id__r.Match_Making_Schedules__c,User_id__c, User_id__r.UserName from User_Profile_Event__c where User_id__c=:UserInfo.getuserId() and IsMatchMakingUser__c=true order by createddate desc]){
      options.add(new selectOption(upe.EV_id__r.id,upe.EV_id__r.EV_Title__c)); 
      events.add(upe.EV_id__r.id);
    }
  
     
   options1 = new List<SelectOption>();
        
    Schema.DescribeFieldResult fieldResult = AttendeeSummary__c.AS_PrimaryBusinessCategory1__c.getDescribe();
  List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
   for( Schema.PicklistEntry f : ple)
   {
      options1.add(new SelectOption(f.getLabel(), f.getValue()));
   }    
  system.debug('22222222222222222222 '+options1);
    Psettings = new List<Profile_Settings__c> ();
    Psettings = [SELECT id,DBA__c,exceptional_keywords__c,Website__c,BBB_Number__c,Salutation__c,Contact_Image__c,Company_Logo__c,Additional_Company_videos__c,Additional_Company_Brouchers__c,Location__c,Country__c,Primary_Business_Category__c,Secondary_Business_Category__c,Distributors_Country__c,Commodities__c,Manufatures_Country__c,Geographical_Region__c,Certificate_Processed_by_RPO__c,Business_Description__c,Company_Name__c,Title__c,Mobile__c,Email_Id__c,First_Name__c,KeyWords__c,Last_Name__c,NAICS_Codes__c,Work_Address__c,Work_phone__c FROM Profile_Settings__c WHERE Event__r.id =: SelectedEvent AND Name=: 'Corporate' ];
  
  EventChange();
  tagslist = [select id,Default_Name__c,Alias_Name__c from Tags__c where Event__c = : selectedEvent];
       for(Tags__c tt: tagslist ){
       if(tt.Default_Name__c == 'Attendee'){
       attendeealias = tt.Alias_Name__c;
       }else if(tt.Default_Name__c == 'Exhibitor'){
       exhibitoralias = tt.Alias_Name__c;
       }
       
       }
 }
 
 
 
// Show corporates while page is loading
 public void EventChange(){
  try{
   eventtimedetails =[select MatchMaking_Type__c,BreakTime_Between_Appointments__c,Match_Making_Schedules__c,MM_Slot_Timeperiod__c,MM_Start_Date__c,MM_End_Date__c,
                                          MM_End_Time__c,MM_Firstaday_EndTime__c,MM_Firstaday_startTime__c,MM_Secondaday_EndTime__c,
                                          MM_Secondaday_startTime__c  from Event__c where id =:selectedEvent];
   
    boothadmins = new SET<string>();
    mapEmailwithUpeId = new MAP<string,id>();
    mapEmailwithUpeId1 = new MAP<string,User_Profile_Event__c>();
   
  for(User_Profile_Event__c UPE : [Select BT_id__r.BT_Location__c,BT_id__r.MM_TableNo__c,User_id__r.userName,id,EV_id__c,User_id__c,Profile_id__c,Status__c,IsMatchMakingUser__c from User_Profile_Event__c  where IsMatchMakingUser__c=true and EV_id__r.id=:selectedEvent and  MAtchMakingProfile__c='Corporate' and Request_for_upgrade_profile__c=false]){
     boothadmins.add(UPE.User_id__r.userName);
     mapEmailwithUpeId.put(UPE.User_id__r.userName,UPE.id);
     mapEmailwithUpeId1.put(UPE.User_id__r.userName,UPE);
  }
  
  upes = new List<AttendeeSummary__c>();
  
  upes =[Select a.As_prefixNew__c ,a.As_SuffixNew__c,a.As_Shipping_Country__c,a.As_Shipping_States__c,a.SystemModstamp, a.OwnerId, a.Name, a.LastModifiedDate, a.LastModifiedById,a.AS_uniqueField__c,
                  a.LastActivityDate, a.IsDeleted, a.Id, a.CreatedDate, a.CreatedById,
                  a.AS_WorkZipCode__c, a.AS_WorkState__c, a.AS_WorkPoBox__c, a.AS_WorkPhone__c, 
                  a.AS_WorkCountry__c, a.AS_WorkCity__c, a.AS_WorkAddress2__c, a.AS_WorkAddress1__c, 
                  a.AS_WebsiteUrl__c, a.AS_Title__c, a.AS_ThroughEventBrite__c, a.AS_Suffix__c, 
                  a.AS_ShippingZipcode__c, a.AS_ShippingState__c, a.AS_ShippingPoBox__c, a.AS_ShippingPhone__c, 
                  a.AS_ShippingCountry__c, a.AS_ShippingCity__c, a.AS_ShippingAddress2__c, a.AS_ShippingAddress1__c,
                  a.AS_SecondaryBusinessCategory1__c, a.AS_PrimaryBusinessCategory1__c, a.AS_Prefix__c, 
                  a.AS_NumberOfEmployees__c, a.AS_NAICSCode_5__c, a.AS_NAICSCode_4__c, a.AS_NAICSCode_3__c, 
                  a.AS_NAICSCode_2__c, a.AS_NAICSCode_1__c, a.AS_LastName__c, a.AS_ImageUrl__c, a.AS_HomeZipcode__c,
                  a.AS_HomeState__c, a.AS_HomePoBox__c, a.AS_HomePhone__c, a.AS_HomeCountry__c, a.AS_HomeCity__c,
                  a.AS_HomeAddress2__c, a.AS_HomeAddress1__c, a.AS_Gender__c, a.AS_FirstName__c, a.AS_FaxNumber__c,
                  a.AS_Email__c, a.AS_DiversityType__c, a.AS_Company__c, a.AS_CellPhone__c, 
                  a.AS_BusinessRevenue__c, a.AS_BusinessEstablishedDate__c, a.AS_BusinessDescription__c,
                  a.AS_BlogUrl__c, a.AS_BirthDate__c, a.AS_Age__c,a.AS_Work_Country__c,a.AS_Work_States__c,a.As_Home_Country__c,a.As_Home_State__c,AS_BusinessTaxId__c,AS_WorkZip__c,AS_HomeZip__c,AS_shippingzip__c,
                  AS_BusinessDunsNumber__c,Exhibitor_company_imageUrl__c,Keywords__c From AttendeeSummary__c a where a.AS_Email__c IN :boothadmins Order By AS_company__c ];
  
       makeTwoLists(upes);
       }catch(exception e){}
       
     
       
       
  }
 
  public map<date,list<string>> slotmap {get;set;}
  public MAP<string,EventSchedule__c>  mapStrWithES{get;set;}
  public List<maptimeWithEvesc> maptimeList{get;set;}
   public List<addendDateclass> dateInn{get;set;}

   
   
// Check number of max slots and diisplay Slot Timings
     public list<Event_Breaks__c> blokslistexist {get ; set ;}
     public string listvals {get ; set ;}
    public PageReference showSchedule() {
    
    selectedEmail = Apexpages.currentpage().getParameters().get('selectedEmail');
    exbitorSummary = new AttendeeSummary__c ();
     mapStrWithES= new MAP<string,EventSchedule__c>();
  
     Commanforstates cst = new Commanforstates ();
     GlobalAttendee Gatt = new GlobalAttendee ();
     
     exbitorSummary=Gatt.ReturnAttendee(selectedEmail);
     exbitorSummary.AS_Work_States__c=cst.mapstate(exbitorSummary.AS_Work_States__c);
   
      scheduleddays1 ='';
      scheduleddays2='';
      SET<Date> eventDates  = new SET<Date>();
      
         
      for(EventSchedule__c evd:[SELECT MM_To_EAM__r.AS_Id__r.AS_Email__c,MM_To_EAM__r.AS_Id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.BT_id__r.BT_Name__c,id,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_slot_Date__c from EventSchedule__c where EV_id__c=:selectedEvent and Is_Matchmaking__c=true and MM_To_EAM__r.AS_id__r.AS_Email__c=:userInfo.getUserName() and (MM_Slot_Status__c ='Pending' OR MM_Slot_Status__c ='Accepted') and (MM_slot_StartTime__c!=null and MM_Slot_End_Time__c!=null)]){
        mapStrWithES.put(evd.MM_slot_Date__c+evd.MM_slot_StartTime__c+'-'+evd.MM_Slot_End_Time__c,evd);
      }
     
     
    
        for(EventSchedule__c eventShedules:[SELECT MM_To_EAM__r.AS_Id__r.AS_Email__c,id,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_slot_Date__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_EAM__r.AS_Id__r.AS_Company__c from EventSchedule__c where EV_id__c=:selectedEvent and Is_Matchmaking__c=true and  MM_To_UPE__r.User_id__r.UserNAme=:selectedEmail and (MM_Slot_Status__c ='Pending' OR MM_Slot_Status__c ='Accepted') and (MM_slot_StartTime__c!=null and MM_Slot_End_Time__c!=null)]){
            mapStrWithES.put(eventShedules.MM_slot_Date__c+eventShedules.MM_slot_StartTime__c+'-'+eventShedules.MM_Slot_End_Time__c,eventShedules);
            
        }
    
    
       MAP<date,integer> mapDateWithMaxapp = new MAP<date,integer>();
         //for(aggregateResult arr :[SELECT count(id) numid,MM_slot_Date__c Name from EventSchedule__c where EV_id__c=:selectedEvent and Is_Matchmaking__c=true and  MM_To_UPE__r.User_id__r.UserNAme=:selectedEmail and (MM_Slot_Status__c ='Pending' OR MM_Slot_Status__c ='Accepted') and (MM_slot_StartTime__c!=null and MM_Slot_End_Time__c!=null) group by MM_slot_Date__c]){
         for(aggregateResult arr :[SELECT count(id) numid,MM_slot_Date__c Name from EventSchedule__c where EV_id__c=:selectedEvent and Is_Matchmaking__c=true and  MM_To_EAM__r.AS_id__r.AS_Email__c=:userInfo.getUserName() and (MM_Slot_Status__c ='Pending' OR MM_Slot_Status__c ='Accepted') and (MM_slot_StartTime__c!=null and MM_Slot_End_Time__c!=null) group by MM_slot_Date__c]){
           
           integer  Quantity = (Integer) arr.get('numid');
            date dt= (date) arr.get('Name');
            mapDateWithMaxapp.put(dt,Quantity );
        
        }
      
      system.debug('BBBBBBBBBBBBBBBBBBBBB '+mapDateWithMaxapp);
    
    
       dateInn = new List<addendDateclass>();
        
       for(MatchLeads_Days__c EvDays:[select id,Break_Time_between_slots__c,End_Time__c,Event__c,MatchLeads_Date__c, MAX_noOf_appontments__c,Slot_Time_period__c,Start_time__c from MatchLeads_Days__c where Event__c=:selectedEvent and MatchLeads_Date__c!=null]){
          eventDates.add(EvDays.MatchLeads_Date__c);
          slotmap  = new MAP<DATE,LIST<String>>();
          slotmap = MM_Utility.giveEventTimingsWithDates(SelectedEvent, EvDays.MatchLeads_Date__c);
          maptimeList = new List<maptimeWithEvesc>();
          System.debug('UUUUUUUUUUU '+slotmap.size());
          if(slotmap.size() >0){
            for(string dateTimes:slotmap.get(EvDays.MatchLeads_Date__c)){
              system.debug('DDDDDDDDDDD '+dateTimes);
              maptimeList.add(new maptimeWithEvesc(dateTimes,mapStrWithES.get(EvDays.MatchLeads_Date__c+dateTimes))); 
            }
            }
             string reachMaxnumber='';  
          if(EvDays.MAX_noOf_appontments__c <= mapDateWithMaxapp.get(EvDays.MatchLeads_Date__c)){
            reachMaxnumber ='You have scheduled max number of Appointments for this day';
          }     
                blokslistexist = new LIST<Event_Breaks__c> ();
                User_Profile_Event__c upeid = [select id from User_Profile_Event__c where User_id__r.UserNAme=:selectedEmail AND EV_id__c =:selectedEvent AND IsMatchMakingUser__c =: true ];
                blokslistexist = [select id,Break_End_Time__c,Break_Start_Time__c from Event_Breaks__c where User_Profile_Event__c =: upeid.id AND MatchLeads_Days__c =: EvDays.id];
                 listvals = '';
               system.debug('-----------------blocklist--------------'+listvals);
                   If(blokslistexist.size() != 0){
                       for(Event_Breaks__c evb: blokslistexist ){  
                           listvals += evb.Break_Start_Time__c+'-'+evb.Break_End_Time__c+',';
                       }
                       }
                system.debug('-----------------blocklist--------------'+listvals);
                dateInn.add(new addendDateclass(EvDays.MatchLeads_Date__c,maptimeList,reachMaxnumber,listvals));
            
         }
     displaySchedule  =true;
    system.debug('CCCCCCCCCCCCCCC '+dateInn);
    return null;
    }





    public void closeSchedule(){
    
    
        displaySchedule= FALSE;
        displayScheduleerror= FALSE;
    
    }

        public class maptimeWithEvesc{
            public string slottime{get;set;}
            public EventSchedule__c slotName{get;set;}
            public maptimeWithEvesc(string xs,EventSchedule__c xd){
             this.slottime = xs;
             this.slotName =xd;
            }
            
       }
   
 public void globalSchedule(string selectedEmail,event__c eventtimedetails){
 
 }
  
   
   public class addendDateclass{
    public string errorreached{get;set;}
    public string sTime{get;set;}
    public List<maptimeWithEvesc> mapListTime{get;set;}
    public string bslot {get ; set ;}
    public addendDateclass(date ttime,List<maptimeWithEvesc> listm,string sde,string bslot){
      string dayone =string.valueOf(ttime);
       this.errorreached =sde;
         if(dayone !=null && dayone !=''){
            string[] str =  dayone.split('-');
          this.sTime=str[1]+'/'+str[2]+'/'+str[0];
       
       this.mapListTime=listm;
       this.bslot = bslot;
     }   
   }
   
   }





public List<Widget__c> videos {get ; set ;}
public User_Profile_Event__c upeforTable {get;set;}
    public PageReference viewProfile() {
    Psettings = new List<Profile_Settings__c> ();
    Psettings = [SELECT id,DBA__c,Website__c,exceptional_keywords__c,Salutation__c,Company_Logo__c,Contact_Image__c,BBB_Number__c,Additional_Company_videos__c,Additional_Company_Brouchers__c,Location__c,Country__c,Primary_Business_Category__c,Secondary_Business_Category__c,Distributors_Country__c,Manufatures_Country__c,Commodities__c,Geographical_Region__c,Certificate_Processed_by_RPO__c,Business_Description__c,Company_Name__c,Title__c,Mobile__c,Email_Id__c,First_Name__c,KeyWords__c,Last_Name__c,NAICS_Codes__c,Work_Address__c,Work_phone__c FROM Profile_Settings__c WHERE Event__r.id =: SelectedEvent AND Name=: 'Corporate' ];
  system.debug('pppppppppppppppppppppppppppppppppppppppppppppppppppppp'+Psettings[0]);
   upeforTable  =new User_Profile_Event__c();
  string viewEmail = Apexpages.currentpage().getParameters().get('viewEmail');
 
  
   upeforTable =mapEmailwithUpeId1.get(viewEmail); 
    vewProfileEAM = new AttendeeSummary__c ();
    GlobalAttendee Gatt = new GlobalAttendee ();
    vewProfileEAM=Gatt.ReturnAttendee(viewEmail);
    
     Commanforstates  gts = new Commanforstates ();
     
    attchments = new list<Attachment>();
    videos = new List<Widget__c>();
    attchments = [SELECT Id, Name,Description,ContentType FROM Attachment where parentId=:vewProfileEAM.Id];
    videos = [Select id,YouTubeId_c__c From Widget__c Where AttendeeSummary__r.id =: vewProfileEAM.Id];
        system.debug('=========== ppppppppp ' + attchments );
     if(vewProfileEAM.AS_Work_States__c!=null){
        vewProfileEAM.AS_Work_States__c =gts.mapstate(vewProfileEAM.AS_Work_States__c);
     }
    
    
     vieProfileBool = false;
        return null;
    }


  public PageReference ClosePopup() {
   displaySchedule  =false;
        return null;
    }

  public PageReference CloseviewPopup() {
   vieProfileBool = false;
        return null;
    }

public PageReference ClearAll()
    {
          keyword=null;
          Name=null;
          NAICSCodes1=null;
          Commodity1=null;
          PrimaryIndustry=new string[]{};
          searchUpe();
return null;
    }

 public PageReference searchUpe() {
   
 try{
 system.debug('hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii '+keyword);
 
  String  Query ='Select Keywords__c,id,AS_LastName__c,AS_FirstName__c,AS_Company__c,AS_Email__c,AS_ImageUrl__c,Exhibitor_company_imageUrl__c from AttendeeSummary__c where AS_Email__c In :boothadmins';
     seeQuery =Query ;
     
     integer abd =0;
     if(PrimaryIndustry.size()>0){
     
      for(string s: PrimaryIndustry){
      if(abd==0){
        Query =Query + ' And (AS_PrimaryBusinessCategory1__c = \''+s+'\'';
      }else{
         Query =Query +' OR AS_PrimaryBusinessCategory1__c = \''+s+'\'';
      }
    abd++;
     }
     Query =Query +')';
     }
     
     
     
    /*  String searchString = 'SELECT Name, Id FROM AttendeeSummary__c WHERE  ';
      String keyWordstring='';
        if(keyword != null && keyword != '' ){
            //Keywords__c
            keyWordstring ='(';
            for(String s:keyword.split(',')){
                keyWordstring += 'Keywords__c LIKE \'%'+s+'%\' OR ';
            } 
            
            if(keyWordstring.endsWithIgnoreCase('OR ')){
                searchString +=  keyWordstring.subString(0, keyWordstring.LastIndexOf('OR')) + ' ) AND ';
            }
        }*/
     
   if(keyword!=null && keyword!=''){
     // Query =Query + ' And (Keywords__c Like \'%'+keyword+'%\'' +')' ;
      List< AttendeeSummary__c> AttforKey =[Select a.As_prefixNew__c ,a.As_SuffixNew__c,a.As_Shipping_Country__c,a.As_Shipping_States__c,a.SystemModstamp, a.OwnerId, a.Name, a.LastModifiedDate, a.LastModifiedById,a.AS_uniqueField__c,
                  a.LastActivityDate, a.IsDeleted, a.Id, a.CreatedDate, a.CreatedById,
                  a.AS_WorkZipCode__c, a.AS_WorkState__c, a.AS_WorkPoBox__c, a.AS_WorkPhone__c, 
                  a.AS_WorkCountry__c, a.AS_WorkCity__c, a.AS_WorkAddress2__c, a.AS_WorkAddress1__c, 
                  a.AS_WebsiteUrl__c, a.AS_Title__c, a.AS_ThroughEventBrite__c, a.AS_Suffix__c, 
                  a.AS_ShippingZipcode__c, a.AS_ShippingState__c, a.AS_ShippingPoBox__c, a.AS_ShippingPhone__c, 
                  a.AS_ShippingCountry__c, a.AS_ShippingCity__c, a.AS_ShippingAddress2__c, a.AS_ShippingAddress1__c,
                  a.AS_SecondaryBusinessCategory1__c, a.AS_PrimaryBusinessCategory1__c, a.AS_Prefix__c, 
                  a.AS_NumberOfEmployees__c, a.AS_NAICSCode_5__c, a.AS_NAICSCode_4__c, a.AS_NAICSCode_3__c, 
                  a.AS_NAICSCode_2__c, a.AS_NAICSCode_1__c, a.AS_LastName__c, a.AS_ImageUrl__c, a.AS_HomeZipcode__c,
                  a.AS_HomeState__c, a.AS_HomePoBox__c, a.AS_HomePhone__c, a.AS_HomeCountry__c, a.AS_HomeCity__c,
                  a.AS_HomeAddress2__c, a.AS_HomeAddress1__c, a.AS_Gender__c, a.AS_FirstName__c, a.AS_FaxNumber__c,
                  a.AS_Email__c, a.AS_DiversityType__c, a.AS_Company__c, a.AS_CellPhone__c, 
                  a.AS_BusinessRevenue__c, a.AS_BusinessEstablishedDate__c, a.AS_BusinessDescription__c,
                  a.AS_BlogUrl__c, a.AS_BirthDate__c, a.AS_Age__c,a.AS_Work_Country__c,a.AS_Work_States__c,a.As_Home_Country__c,a.As_Home_State__c,AS_BusinessTaxId__c,AS_WorkZip__c,AS_HomeZip__c,AS_shippingzip__c,
                  AS_BusinessDunsNumber__c,Exhibitor_company_imageUrl__c,Keywords__c From AttendeeSummary__c a where a.AS_Email__c IN :boothadmins Order By AS_company__c ];
  
      SET<id>  attidsforFilter = new SET<id>();
      for(AttendeeSummary__c asum: AttforKey){
        if(null != asum.Keywords__c){
           if((asum.Keywords__c.TolowerCase()).contains(keyword.TolowerCase())){
            attidsforFilter.add(asum.id);
           }
        }    
     }
     Query =Query + ' And Id IN :attidsforFilter';
   } 
    
     
     
if(Name!=null && Name!=''){
   Query =Query + ' And (AS_Company__c Like \'%'+Name.trim()+'%\'' +')' ;
  }
       
  if(NAICSCodes1!=null && NAICSCodes1!=''){
    
    Query =Query +' AND (AS_NAICSCode_1__c Like \'%'+NAICSCodes1.trim()+'%\''+' OR AS_NAICSCode_2__c Like \'%'+NAICSCodes1.trim()+'%\''+' OR AS_NAICSCode_3__c Like \'%'+NAICSCodes1.trim()+'%\''+' OR As_NAICSCode_4__c Like \'%'+NAICSCodes1.trim()+'%\''+' OR As_NAICSCode_5__c Like \'%'+NAICSCodes1.trim()+'%\''+')';

    //Query =Query +' AND (AS_NAICSCode_1__c ='+NAICSCodes1+' OR AS_NAICSCode_2__c ='+NAICSCodes1+' OR AS_NAICSCode_3__c ='+NAICSCodes1+')';
   }   
    if(NAICSCodes2!=null && NAICSCodes2!=''){
      
        Query =Query +' AND (AS_NAICSCode_2__c Like \'%'+NAICSCodes2.trim()+'%\''+' OR AS_NAICSCode_1__c Like \'%'+NAICSCodes2.trim()+'%\''+' OR AS_NAICSCode_3__c Like \'%'+NAICSCodes2.trim()+'%\''+' OR As_NAICSCode_4__c Like \'%'+NAICSCodes2.trim()+'%\''+' OR As_NAICSCode_5__c Like \'%'+NAICSCodes2.trim()+'%\''+')';

      //Query =Query +' AND (AS_NAICSCode_2__c ='+NAICSCodes2+' OR AS_NAICSCode_1__c ='+NAICSCodes2+' OR AS_NAICSCode_3__c ='+NAICSCodes2+')';
     }
   if(NAICSCodes3!=null && NAICSCodes3!=''){
    
    Query =Query +' AND (AS_NAICSCode_3__c Like \'%'+NAICSCodes3.trim()+'%\''+' OR AS_NAICSCode_2__c Like \'%'+NAICSCodes3.trim()+'%\''+' OR AS_NAICSCode_1__c Like \'%'+NAICSCodes3.trim()+'%\''+' OR As_NAICSCode_4__c Like \'%'+NAICSCodes3.trim()+'%\''+' OR As_NAICSCode_5__c Like \'%'+NAICSCodes3.trim()+'%\''+')';
    //Query =Query +' AND (AS_NAICSCode_3__c ='+NAICSCodes3+' OR AS_NAICSCode_2__c ='+NAICSCodes3+' OR AS_NAICSCode_1__c ='+NAICSCodes3+')';
    }
    
    //Commodities
    if(Commodity1!=null && Commodity1!=''){
        Query =Query +' AND (Commodity_1__c Like \'%'+Commodity1.trim()+'%\''+' OR Commodity_2__c Like \'%'+Commodity1.trim()+'%\''+' OR Commodity_3__c Like \'%'+Commodity1.trim()+'%\''+' OR Commodity_4__c Like \'%'+Commodity1.trim()+'%\''+' OR Commodity_5__c Like \'%'+Commodity1.trim()+'%\''+' OR Commodity_6__c Like \'%'+Commodity1.trim()+'%\''+' OR Commodity_7__c Like \'%'+Commodity1.trim()+'%\''+' OR Commodity_8__c Like \'%'+Commodity1.trim()+'%\''+' OR Commodity_9__c Like \'%'+Commodity1.trim()+'%\''+')';
    }
    if(Commodity2!=null && Commodity2!=''){
        Query =Query +' AND (Commodity_1__c Like \'%'+Commodity2.trim()+'%\''+' OR Commodity_2__c Like \'%'+Commodity2.trim()+'%\''+' OR Commodity_3__c Like \'%'+Commodity2.trim()+'%\''+' OR Commodity_4__c Like \'%'+Commodity2.trim()+'%\''+' OR Commodity_5__c Like \'%'+Commodity2.trim()+'%\''+' OR Commodity_6__c Like \'%'+Commodity2.trim()+'%\''+' OR Commodity_7__c Like \'%'+Commodity2.trim()+'%\''+' OR Commodity_8__c Like \'%'+Commodity2.trim()+'%\''+' OR Commodity_9__c Like \'%'+Commodity2.trim()+'%\''+')';
    }
    if(Commodity3!=null && Commodity3!=''){
        Query =Query +' AND (Commodity_1__c Like \'%'+Commodity3.trim()+'%\''+' OR Commodity_2__c Like \'%'+Commodity3.trim()+'%\''+' OR Commodity_3__c Like \'%'+Commodity3.trim()+'%\''+' OR Commodity_4__c Like \'%'+Commodity3.trim()+'%\''+' OR Commodity_5__c Like \'%'+Commodity3.trim()+'%\''+' OR Commodity_6__c Like \'%'+Commodity3.trim()+'%\''+' OR Commodity_7__c Like \'%'+Commodity3.trim()+'%\''+' OR Commodity_8__c Like \'%'+Commodity3.trim()+'%\''+' OR Commodity_9__c Like \'%'+Commodity3.trim()+'%\''+')';
    }
    if(Commodity4!=null && Commodity4!=''){
        Query =Query +' AND (Commodity_1__c Like \'%'+Commodity4.trim()+'%\''+' OR Commodity_2__c Like \'%'+Commodity4.trim()+'%\''+' OR Commodity_3__c Like \'%'+Commodity4.trim()+'%\''+' OR Commodity_4__c Like \'%'+Commodity4.trim()+'%\''+' OR Commodity_5__c Like \'%'+Commodity4.trim()+'%\''+' OR Commodity_6__c Like \'%'+Commodity4.trim()+'%\''+' OR Commodity_7__c Like \'%'+Commodity4.trim()+'%\''+' OR Commodity_8__c Like \'%'+Commodity4.trim()+'%\''+' OR Commodity_9__c Like \'%'+Commodity4.trim()+'%\''+')';
    }
    if(Commodity5!=null && Commodity5!=''){
        Query =Query +' AND (Commodity_1__c Like \'%'+Commodity5.trim()+'%\''+' OR Commodity_2__c Like \'%'+Commodity5.trim()+'%\''+' OR Commodity_3__c Like \'%'+Commodity5.trim()+'%\''+' OR Commodity_4__c Like \'%'+Commodity5.trim()+'%\''+' OR Commodity_5__c Like \'%'+Commodity5.trim()+'%\''+' OR Commodity_6__c Like \'%'+Commodity5.trim()+'%\''+' OR Commodity_7__c Like \'%'+Commodity5.trim()+'%\''+' OR Commodity_8__c Like \'%'+Commodity5.trim()+'%\''+' OR Commodity_9__c Like \'%'+Commodity5.trim()+'%\''+')';
    }
    if(Commodity6!=null && Commodity6!=''){
        Query =Query +' AND (Commodity_1__c Like \'%'+Commodity6.trim()+'%\''+' OR Commodity_2__c Like \'%'+Commodity6.trim()+'%\''+' OR Commodity_3__c Like \'%'+Commodity6.trim()+'%\''+' OR Commodity_4__c Like \'%'+Commodity6.trim()+'%\''+' OR Commodity_5__c Like \'%'+Commodity6.trim()+'%\''+' OR Commodity_6__c Like \'%'+Commodity6.trim()+'%\''+' OR Commodity_7__c Like \'%'+Commodity6.trim()+'%\''+' OR Commodity_8__c Like \'%'+Commodity6.trim()+'%\''+' OR Commodity_9__c Like \'%'+Commodity6.trim()+'%\''+')';
    }
    if(Commodity7!=null && Commodity7!=''){
        Query =Query +' AND (Commodity_1__c Like \'%'+Commodity7.trim()+'%\''+' OR Commodity_2__c Like \'%'+Commodity7.trim()+'%\''+' OR Commodity_3__c Like \'%'+Commodity7.trim()+'%\''+' OR Commodity_4__c Like \'%'+Commodity7.trim()+'%\''+' OR Commodity_5__c Like \'%'+Commodity7.trim()+'%\''+' OR Commodity_6__c Like \'%'+Commodity7.trim()+'%\''+' OR Commodity_7__c Like \'%'+Commodity7.trim()+'%\''+' OR Commodity_8__c Like \'%'+Commodity7.trim()+'%\''+' OR Commodity_9__c Like \'%'+Commodity7.trim()+'%\''+')';
    }
    if(Commodity8!=null && Commodity8!=''){
        Query =Query +' AND (Commodity_1__c Like \'%'+Commodity8.trim()+'%\''+' OR Commodity_2__c Like \'%'+Commodity8.trim()+'%\''+' OR Commodity_3__c Like \'%'+Commodity8.trim()+'%\''+' OR Commodity_4__c Like \'%'+Commodity8.trim()+'%\''+' OR Commodity_5__c Like \'%'+Commodity8.trim()+'%\''+' OR Commodity_6__c Like \'%'+Commodity8.trim()+'%\''+' OR Commodity_7__c Like \'%'+Commodity8.trim()+'%\''+' OR Commodity_8__c Like \'%'+Commodity8.trim()+'%\''+' OR Commodity_9__c Like \'%'+Commodity8.trim()+'%\''+')';
    }
    if(Commodity9!=null && Commodity9!=''){
        Query =Query +' AND (Commodity_1__c Like \'%'+Commodity9.trim()+'%\''+' OR Commodity_2__c Like \'%'+Commodity9.trim()+'%\''+' OR Commodity_3__c Like \'%'+Commodity9.trim()+'%\''+' OR Commodity_4__c Like \'%'+Commodity9.trim()+'%\''+' OR Commodity_5__c Like \'%'+Commodity9.trim()+'%\''+' OR Commodity_6__c Like \'%'+Commodity9.trim()+'%\''+' OR Commodity_7__c Like \'%'+Commodity9.trim()+'%\''+' OR Commodity_8__c Like \'%'+Commodity9.trim()+'%\''+' OR Commodity_9__c Like \'%'+Commodity9.trim()+'%\''+')';
    }
    
  
  seeQuery =Query;
 system.debug('EEEEEEEEEEEEEEEEEEE '+seeQuery );
  
  upes  =new List<AttendeeSummary__c>();
  upes = DataBase.Query(Query+' Order By AS_company__c'); 
 
  makeTwoLists(upes);
  
 }catch(exception e){} 
  
  return null;
  }
  
  
 
  
  
  
    public boolean dispaySuccessPopup {get;set;}
    public EventSchedule__c esc{get;set;}
   public boolean  dispaySuccessPopup21{get;set;}
   
   
   
    public PageReference Schedules() {
    
    system.debug('3333333333333333333 444444444444444'+selectedEvent  );
  // List<User_Profile_Event__c> UPE211 = new List<User_Profile_Event__c>();
   // UPE211 =[SELECT id from User_Profile_Event__c where EV_id__c=:selectedEvent  and User_id__r.userName=:selectedEmail ];
     
    
    User_Profile_Event__c UPE21 = new User_Profile_Event__c();
    UPE21 =[SELECT id from User_Profile_Event__c where EV_id__c=:selectedEvent  and User_id__r.userName=:selectedEmail ];
     
    //system.debug('3333333333333333333 '+UPE211 );
     List<EventSchedule__c> escdulewe = new List<EventSchedule__c>();
     escdulewe =[select id,MM_To_EAM__c,MM_To_UPE__c from EventSchedule__c where MM_To_UPE__c=:UPE21.id and MM_To_EAM__r.AS_id__r.AS_Email__c=:userInfo.getUserName() and EV_id__c=:selectedEvent and (MM_Slot_Status__c!='cancelled' AND MM_Slot_Status__c!='Rejected' AND MM_Slot_Status__c!='Missed') and (MM_slot_StartTime__c!=null and MM_Slot_End_Time__c!=null)];
     system.debug(escdulewe.size()+'444444444444  '+escdulewe );
    if(escdulewe.size()<=0){
     string[] strtimeValue = new string[]{};
     strtimeValue  = (Apexpages.currentpage().getParameters().get('timeValue')).split('-');
     system.debug(' STRING TIME VALUE   '+strtimeValue);
     if(strtimeValue.size() >0){
     schedulestartTime =strtimeValue[0];
     scheduleendTime =strtimeValue[1];
     }
      scheduledate=Apexpages.currentpage().getParameters().get('dateValue');
      system.debug('3333333333333333333 '+Apexpages.currentpage().getParameters().get('timeValue'));
      
      comments='';
      dispaySuccessPopup =true;
      }else{
         dispaySuccessPopup21 =true;
      }
      
      
      return null;
    }
    
    
    public void CloseSuccessPopup21(){
     dispaySuccessPopup21 =false;
    }
    

 
 

public void makeTwoLists(List<AttendeeSummary__c> upes){
righttsideList = new List<AttendeeSummary__c>();
leftsideList = new List<AttendeeSummary__c>();
 integer i=0;
     for(AttendeeSummary__c atr:upes){
     if (math.mod(i, 2) == 0) {
       leftsideList.add(atr);
     }else{
        righttsideList.add(atr);
     }
      i++;  
    }
  }
  

 public PageReference updateComment() {
    
    Event_Attendee_Mapping__c EAm = [SELECT id from Event_Attendee_Mapping__c where AS_id__r.AS_Email__c = :UserInfo.getUserName()  and  EV_id__c=:selectedEvent];
    
     User_Profile_Event__c UPE = new User_Profile_Event__c();
     UPE = [SELECT id from User_Profile_Event__c where EV_id__c=:selectedEvent  and User_id__r.userName=:selectedEmail];
             
    globalTimeConvertion gr = new globalTimeConvertion();
    EventSchedule__c Eshedule = new EventSchedule__c();
    Eshedule.EV_id__c =selectedEvent;
    Eshedule.MM_To_UPE__c =UPE.id;
    Eshedule.MM_To_EAM__c = EAm.id; 
    Eshedule.MM_slot_Date__c =date.parse(scheduledate);
    Eshedule.MM_slot_StartTime__c =schedulestartTime;
    Eshedule.Is_Matchmaking__c =true;   
    string status ='';
    if(eventtimedetails.MatchMaking_Type__c=='Open'){
     Eshedule.MM_Slot_Status__c ='Accepted';
     status = 'Accepted';
    }else  if(eventtimedetails.MatchMaking_Type__c=='Semi Open'){
     Eshedule.MM_Slot_Status__c ='Pending';
     status = 'Pending';
    }  
    Eshedule.MBE_Corp_Combination__c = EAm.id+'-'+UPE.id+'-'+status ;
    Eshedule.MBE_Timeslot__c = EAm.id+'-'+date.parse(scheduledate)+'-'+schedulestartTime +status ;
    Eshedule.UPE_Timeslot__c = UPE.id+'-'+date.parse(scheduledate)+'-'+schedulestartTime +status ;

    Eshedule.MM_Slot_End_Time__c =scheduleendTime ;
    if(comments!=null && comments!=''){
        Eshedule.Comments__c= comments;   
    } 
   dataBase.saveResult res = dataBase.Insert(Eshedule);
   system.debug('555555555555555 '+res );
    dispaySuccessPopup =false;
    displaySchedule  =false;
        return null;
    }


    public PageReference CloseSuccessPopup() {
    dispaySuccessPopup =false;
    //  displaySchedule  =false;
        return null;
    }

   
    public Pagereference CheckUser(){
       
       Pagereference pg = MM_Utility.checkLogInservice();
       
       return pg;
       
   }

}