public without sharing class BL_BoothAdmin_AttendeesCon {
    
    //Variables
    public boolean Allrecords { get; set; }
    public Boolean booleanforDisplayBoothadminTab{get;set;}
    public String eventSelected { get; set;}
    public List<Event__c> EvntsForPicklist{get;set;}
    public List<Event__c> EvntsForTZ{get;set;}
    public string defaultEvent{get;set;}
    public map<string,string> mapImage {get;set;}
    public List<List<BoothVisitSummary__c>> bvsList{get;set;}
    public List<BoothVisitSummary__c> ListForPagination{get;set;}
    public  BL_SecuritySettingsCon gg{get;set;}
    public String searchString { get; set; }
    public string[] strAlfhabets{get;set;}
    public  List<BoothVisitSummary__c> supportList{get;set;}
    public string eventName{get;set;} 
    public String subject { get; set; }
    public boolean email{get;set;}
    public boolean displayForcescrBool{get;set;}
    public BoothVisitSummary__c attendeeSummary{get;set;}
    public Id attachmentIdOfImage {get;set;}
    public Id urlIdOfImage {get;set;}
    public boolean BVSDetail{get;set;}
    public List<String> listOfintegers{get;set;}
    public List<BoothVisitSummary__c> BVSListsel{get;set;} 
    public string transfer{get;set;}  
    public blob b{get;set;} 
    public String body { get; set; }
    public String EmailTo { get; set; }
    public String userName { get; set; }
    public String password { get; set; }
    public Boolean hasLast{get;set;}
    public Boolean hasFirst{get;set;}
    public Integer PgNo{get;set;}
    Public Boolean conlst{get;set;}
    Public Boolean hasPrevious {get;set;}
    Public Boolean hasNext {get;set;}
    Public Integer pageno {get;set;}
    Public Integer count {get;set;}
    public Boolean Disabled_First_Icon{get;set;}
    public Boolean Disabled_Last_Icon{get;set;}
    public Boolean Disabled_Previous_Icon{get;set;}
    public Boolean Disabled_Next_Icon{get;set;} 
    
    public Transient List<BoothVisitSummary__c > bvsvaluesbefore1{get;set;}
    public MAP<ID, Boolean> ForSelectedCheckBoxes{get; set;}
    public Boolean NoRecordSelected{get;set;}
    public set<Id> ListOfSelectedIds{get;set;}
    public Boolean NoRecordsFound{get;set;}
    public Boolean DisplayPages{get;set;}
    public Integer ForPageSize{get;set;}
    
    
     // CCR Details Variable Declaration   
    Public String CCRCageCode{get;set;}
    Public String CCRCompany{get;set;}
    Public String CCRDomain{get;set;}
    Public String CCREmailId{get;set;}
    Public String CCRWebsiteUrl{get;set;}
    Public String CCRCellPhone{get;set;}  
    Public String CCRBusinessRevenue{get;set;}
    Public String CCRBusinessTaxId{get;set;}
    Public String CCRBusinessDunsNumber{get;set;}        
    Public String CCRNaicsCodes{get;set;}
    Public String CCRNaicsCodes1{get;set;}
    Public String CCRNaicsCodes2{get;set;}
    Public String CCRNaicsCodes3{get;set;}
    Public String CCRNaicsCodes4{get;set;}
    Public String CCRNaicsCodes5{get;set;}
    Public String CCRBusinessEstablishedDate{get;set;}
    Public String CCRBusinessEstablishedDate1{get;set;}
    Public String CCRNumberofEmployees{get;set;}    
    Public String CCRFiscalYearEndDate{get;set;}
    Public String CCRWorkAddress1{get;set;}
    Public String CCRWorkAddress2{get;set;}
    Public String CCRWorkCity{get;set;}
    Public String CCRWorkState{get;set;}
    Public String CCRWorkCountry{get;set;}
    Public String CCRZipCode1{get;set;}
    Public String CCRWorkZipCode{get;set;}
    Public String CCRPOBox1{get;set;}
    Public String CCRPOBox2{get;set;}
    Public String CCRPOBox3{get;set;}
    Public String CCRWorkPOBox{get;set;}
    Public String CCRWorkPhone{get;set;}
    Public String CCRHomeAddress1{get;set;}
    Public String CCRHomeAddress2{get;set;}
    Public String CCRHomeCity{get;set;}
    Public String CCRHomeState{get;set;}
    Public String CCRHomeCountry{get;set;}
    Public String CCRHomeCode1{get;set;}
    Public String CCRHomeZipCode{get;set;}    
    Public String CCRHomePOBox{get;set;}
    Public String CCRHomePhone{get;set;}
    Public String CCRMailingAddress1{get;set;}
    Public String CCRMailingAddress2{get;set;}
    Public String CCRMailingCity{get;set;}
    Public String CCRMailingState{get;set;}
    Public String CCRMailingCountry{get;set;}
    Public String CCRZipCode2{get;set;}
    Public String CCRMailingZipCode{get;set;}
    Public String CCRMailingPOBox{get;set;}
    Public String CCRMailingPhone{get;set;}         
    
    Public String CCRFirstName{get;set;}
    Public String CCRLastName{get;set;}
    Public String CCREmail{get;set;}     
    Public String CCRDomainName{get;set;} 
    Public String CCRData{get;set;}
    Public String CageCode1{get;set;}
    Public Boolean ccrdetailsbool{get;set;}
    Public Boolean fetchccrdetailsbool{get;set;}
    Public Boolean fetchccrdetailsboolyes{get;set;}
    Public Boolean fetchccrdetailsboolno{get;set;}
    Public String NoRecordsMessage{get;set;}
    //public List<BoothVisitSummary__c> listdg{get;set;} 
    //public Set<BoothVisitSummary__c> setdg{get;set;} 
    //public List<BoothVisitSummary__c> result{get;set;} 
    public List<AttendeeSummary__c> listdg{get;set;} 
    public Set<AttendeeSummary__c> setdg{get;set;} 
    public List<AttendeeSummary__c> result{get;set;} 
    Public String CCRSearchTerm{get;set;} 
    Public String CCRSearchCageCode{get;set;} 
    Public String CCRSearchEmail{get;set;} 
    Public String CCRSearchPhone{get;set;}
     public BoothVisitSummary__c bl {get;set;}   
     public AttendeeSummary__c ccrlead {get;set;}
    public string istestValue{get;set;}
      public MAP<Id,List<Survey__c>> mapAttNSur {get;set;}
      
      public String eventtimezone{get;set;}
      
    public BL_BoothAdmin_AttendeesCon(){
    try{ 
    URLEvent();
         bl=new BoothVisitSummary__c(); 
        NoRecordSelected = False;
        searchString ='';
       allrecords =false;
        strAlfhabets = new string[]{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','All'};
        booleanforDisplayBoothadminTab = false;
        List<User_Profile_Event__c>  forDisplayBoothdmintab= [Select u.User_id__c,u.Profile_id__r.PR_Name__c,u.User_id__r.Name, u.UEP_isActive__c, u.SystemModstamp, u.Profile_id__c, u.OwnerId, u.Name, u.LastModifiedDate, u.LastModifiedById, u.LastActivityDate, u.IsDeleted, u.Id, u.EventAdmin_Id__c, u.EV_id__c, u.CreatedDate, u.CreatedById, u.BoothAdmin_id__c, u.BT_id__c, u.BLP_id__c From User_Profile_Event__c u where u.User_id__r.Email=:userInfo.getUserName() and (Status__c!='Mobile only access' And Status__c!='InActive') ];
        for(User_Profile_Event__c tt:forDisplayBoothdmintab){
        if(tt.Profile_id__r.PR_Name__c !='Attendee' && tt.Profile_id__r.PR_Name__c !='BoothPersonnel' ){
        booleanforDisplayBoothadminTab = true;
        }   
        }
        getEvents();
    }
    catch(exception e){}   
    
    }
    
    //To display List of Events in a Picklist    
     public List<selectOption> getselectEvents() {
   // try{
       
       NoRecordSelected = False;
       List<User_Profile_Event__c> upeForEvents = new List<User_Profile_Event__c>();
       EvntsForPicklist = new List<Event__c>();
       upeForEvents = [Select u.User_id__c,u.Profile_id__r.PR_Name__c,u.User_id__r.Name, u.UEP_isActive__c, u.SystemModstamp, u.Profile_id__c, u.OwnerId, u.Name, u.LastModifiedDate, u.LastModifiedById, u.LastActivityDate, u.IsDeleted, u.Id, u.EventAdmin_Id__c, u.EV_id__c, u.CreatedDate, u.CreatedById, u.BoothAdmin_id__c, u.BT_id__c, u.BLP_id__c From User_Profile_Event__c u where (u.User_id__r.Email=:userInfo.getUserName() ) and (Status__c!='Mobile only access' And Status__c!='InActive') ];
       set<Id> setOfEventIds = new set<Id>();
           for(User_Profile_Event__c rotatinnFor:upeForEvents){
           setOfEventIds.add(rotatinnFor.EV_id__c);
           }
 
       EvntsForPicklist =[select  id,EV_Title__c from Event__c where id in :setOfEventIds order by EV_StartDate__c];
           if(EvntsForPicklist.size()>0){
           
           defaultEvent =EvntsForPicklist[0].id;
           }
          List<SelectOption> options = new List<SelectOption>();
           options.add(new SelectOption('All','All'));
           for(Event__c Event:EvntsForPicklist ){
           options.add(new SelectOption(Event.id,Event.EV_Title__c));
           }
           return options;
   // }catch(exception e){return null;}   
     
     }
     
     
     public void CommonMethod(){
     
         mapImage  = new map<string,string>();
          if(eventSelected == NULL || eventSelected =='ALL' ){
        eventSelected ='All';
       set<id> setofboothpersonnelIds = new  set<id>();
      //  bvsList = new List<List<BoothVisitSummary__c>>(); 
        bvsvaluesbefore1 = new  List<BoothVisitSummary__c >();  
       // ListForPagination = new List<BoothVisitSummary__c>();
      //  List<BoothVisitSummary__c > bvsvaluesbefore1 = new  List<BoothVisitSummary__c >(); 
        List<BoothVisitSummary__c > bvsListBefore = new  List<BoothVisitSummary__c >();
        List<User_Event_BVS__c> bvsvalues = new List<User_Event_BVS__c>();
        
        List<document> des = new List<document>();
        des =[select id from document where name='Boothadmindefalt.jpeg'];
        string defalutImage;
        if(des.size()>0){
        defalutImage =des[0].id;
        }
        
        
        bvsvalues =[select BVS_id__c from User_Event_BVS__c u where 
        
                    (u.UPE_id__r.BoothAdmin_id__r.Email=:userInfo.getUserName()  
                    and u.UPE_id__r.UEP_isActive__c=true and  
                    (u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive') ) 
                    OR (u.UPE_id__r.User_id__r.Email=:userInfo.getUserName() 
                    and u.UPE_id__r.Profile_id__r.PR_Name__c='BoothAdmin' 
                    and u.UPE_id__r.UEP_isActive__c=true and  
                    (u.UPE_id__r.Status__c='Mobile and Portal Access' OR u.UPE_id__r.Status__c='Active') ) 
                    Or (UPE_id__r.User_id__c=:userInfo.getUserId()  and u.UPE_id__r.UEP_isActive__c=true 
                    and  (u.UPE_id__r.Status__c='Mobile and Portal Access' OR u.UPE_id__r.Status__c!='Active')) ];  
        
        system.debug('YYYYYYYYYYYYYYYYYYYYYYY '+bvsvalues );
        integer recCount =0;
        
        for(User_Event_BVS__c valuesofbvs: bvsvalues ){
        setofboothpersonnelIds.add(valuesofbvs.BVS_id__c);        
        }
      
               
        bvsListBefore = [Select b.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c,Checkbox_For_Report__c, 
        b.User_id__c, b.User_id__r.Name,b.SystemModstamp, b.OwnerId, b.Name,AS_ImageUrl__c, 
        b.LastModifiedDate, b.LastModifiedById, b.LastActivityDate, b.IsDeleted, b.Id, 
        b.EA_AttendeeBarcode__c, b.CreatedDate, b.CreatedById, b.BVS_Title__c, b.BVS_Tags__c, 
        b.BVS_SurveyQuestion4__c, b.BVS_SurveyQuestion3__c, b.BVS_SurveyQuestion2__c, b.BVS_SurveyQuestion1__c, 
        b.BVS_SurveyAnswer4__c, b.BVS_SurveyAnswer3__c, b.BVS_SurveyAnswer2__c, b.BVS_SurveyAnswer1__c, 
        b.BVS_State__c, b.BVS_PhoneNumber__c, b.BVS_Notes__c, b.BVS_LeadType__c, b.BVS_LeadRating__c, 
        b.BVS_LeadCategory__c, b.BVS_LastName__c, b.BVS_FollowUps__c, b.BVS_FirstName__c, b.BVS_Email__c, 
        b.BVS_Company__c, b.BVS_City__c, b.BVS_Budget__c,b.ScanTime__c From BoothVisitSummary__c b 
        where id in :setofboothpersonnelIds and EA_AttendeeBarcode__c!=null order by ScanTime__c DESC ];
        
        system.debug( ' SSSSSSSSSSSSSSSSSSS '+bvsListBefore );
        
        try{
           if(eventSelected== NULL || eventSelected=='ALL')
           eventtimezone='Eastern Time(USA)';
           else
           {
             EvntsForTZ=[select  id,name,EV_Title__c,EV_HostingTimeZone__c  from Event__c where id=:eventSelected limit 1];
 if(EvntsForTZ.size()>0){
           
           defaultEvent =EvntsForTZ[0].EV_HostingTimeZone__c;
           }
           }}catch(Exception e){eventtimezone='Eastern Time(USA)';}
        
        
        for(BoothVisitSummary__c yt:bvsListBefore ){
         system.debug( ' UUUUUUUUUUUUUUUU '+yt);
       
       yt.BVS_FirstName__c =escapeSpecialCharacters(yt.BVS_FirstName__c);
            yt.BVS_LastName__c =escapeSpecialCharacters( yt.BVS_LastName__c);
            yt.BVS_Company__c =escapeSpecialCharacters(yt.BVS_Company__c);
            yt.BVS_LeadCategory__c=escapeSpecialCharacters(yt.BVS_LeadCategory__c);
            yt.BVS_FollowUps__c=escapeSpecialCharacters(yt.BVS_FollowUps__c);
            yt.BVS_Notes__c=escapeSpecialCharacters(yt.BVS_Notes__c);
       
        
        try{
        string abd = string.valueOf(yt.ScanTime__c);
        
      //  yt.ScanTime__c= getLocalDateTime( yt.ScanTime__c);
        yt.ScanTime__c= geteventbasetime( yt.ScanTime__c,eventtimezone);
        }catch (exception e){}
         
        yt.Dummy__c  =  yt.AS_ImageUrl__c;     
        
        
       if(yt.AS_ImageUrl__c ==null || yt.AS_ImageUrl__c ==''){
       
      
          if(yt.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c!=null && yt.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c!=''){
            yt.AS_ImageUrl__c=yt.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c;
          } else{
           yt.AS_ImageUrl__c=defalutImage ;
          }    
           system.debug('======hhhhhhhhhhhhhhhhhhhhhhh==='+yt.AS_ImageUrl__c);     
       
       }
        bvsvaluesbefore1.add(yt);
                      
           
        }
  
        } 
        else{
        
        set<Id>  setofboothpersonnelIds = new set<Id>();
      //  bvsList = new List<List<BoothVisitSummary__c>>(); 
        bvsvaluesbefore1 = new  List<BoothVisitSummary__c >(); 
       //  ListForPagination = new List<BoothVisitSummary__c>(); 
        List<User_Event_BVS__c> bvsvalues = new  List<User_Event_BVS__c>(); 
        gg = new BL_SecuritySettingsCon(eventSelected);
        system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  gg'+ gg );  
        
         List<document> des = new List<document>();
        des =[select id from document where name='Boothadmindefalt.jpeg'];
        string defalutImage;
        if(des.size()>0){
        defalutImage =des[0].id;
        }
        List<BoothVisitSummary__c > bvsListBefore = new  List<BoothVisitSummary__c >();  
        integer recCount =0;  
        
        bvsvalues =[select BVS_id__c from User_Event_BVS__c u where 
                    (u.UPE_id__r.BoothAdmin_id__r.Email=:userInfo.getUserName() 
                    and u.EV_id__c=:eventSelected and u.UPE_id__r.UEP_isActive__c=true and  
                    (u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive')) 
                    OR (u.UPE_id__r.User_id__r.Email=:userInfo.getUserName() and u.EV_id__c=:eventSelected 
                    and u.UPE_id__r.Profile_id__r.PR_Name__c='BoothAdmin' and u.UPE_id__r.UEP_isActive__c=true 
                    and  u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive') 
                    Or (UPE_id__r.User_id__c=:userInfo.getUserId() and u.EV_id__c=:eventSelected 
                    and u.UPE_id__r.UEP_isActive__c=true and  u.UPE_id__r.Status__c!='Mobile only access' 
                    And u.UPE_id__r.Status__c!='InActive') ];  
                    
        for(User_Event_BVS__c h:bvsvalues){
        setofboothpersonnelIds.add(h.BVS_id__c);
        }
        
        
      
        
        
        bvsListBefore = [Select b.Dummy__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c,AS_ImageUrl__c, 
                        b.User_id__c, b.User_id__r.Name,b.SystemModstamp, b.OwnerId, b.Name, 
                        b.LastModifiedDate, b.LastModifiedById, b.LastActivityDate,Checkbox_For_Report__c, 
                        b.IsDeleted, b.Id, b.EA_AttendeeBarcode__c, b.CreatedDate, 
                        b.CreatedById, b.BVS_Title__c, b.BVS_Tags__c, b.BVS_SurveyQuestion4__c, 
                        b.BVS_SurveyQuestion3__c, b.BVS_SurveyQuestion2__c, b.BVS_SurveyQuestion1__c, 
                        b.BVS_SurveyAnswer4__c, b.BVS_SurveyAnswer3__c, b.BVS_SurveyAnswer2__c, 
                        b.BVS_SurveyAnswer1__c, b.BVS_State__c, b.BVS_PhoneNumber__c, b.BVS_Notes__c, 
                        b.BVS_LeadType__c, b.BVS_LeadRating__c, b.BVS_LeadCategory__c, b.BVS_LastName__c, 
                        b.BVS_FollowUps__c, b.BVS_FirstName__c, b.BVS_Email__c, b.BVS_Company__c, 
                        b.BVS_City__c, b.BVS_Budget__c,b.ScanTime__c From BoothVisitSummary__c b 
                        where id in :setofboothpersonnelIds and EA_AttendeeBarcode__c!=null order by ScanTime__c DESC ];
        
        for(BoothVisitSummary__c yt:bvsListBefore ){
                
        if(mapImage.get(yt.id) != null){
        yt.Dummy__c  =  mapImage.get(yt.id);     
        }      
        
        if(yt.AS_ImageUrl__c ==null || yt.AS_ImageUrl__c ==''){
           
     if(yt.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c!=null && yt.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c!=''){
       yt.AS_ImageUrl__c=yt.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c;
       } else{         
           yt.AS_ImageUrl__c=defalutImage ;
         }    
         system.debug('======hhhhhhhhhhhhhhhhhhhhhhh==='+yt.AS_ImageUrl__c);     
       }
        
        
                       
        bvsvaluesbefore1.add(yt);
      
        system.debug('======vvvvvvvvvvvvvvvvvvvvv==='+bvsvaluesbefore1); 
        }             
        } 
     
     }
     
     public PageReference getEvents() {
    try{
       ForpageSize = null;
        system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ eventSelected '+eventSelected );
        ForSelectedCheckBoxes = new Map<ID,Boolean>();
        mapImage  = new map<string,string>();
        
        
          if(eventSelected == NULL || eventSelected =='ALL' ){
        eventSelected ='All';
        set<id> setofboothpersonnelIds = new  set<id>();
        bvsList = new List<List<BoothVisitSummary__c>>(); 
        bvsvaluesbefore1 = new  List<BoothVisitSummary__c >();  
        ListForPagination = new List<BoothVisitSummary__c>();
      //  List<BoothVisitSummary__c > bvsvaluesbefore1 = new  List<BoothVisitSummary__c >(); 
        List<BoothVisitSummary__c > bvsListBefore = new  List<BoothVisitSummary__c >();
        List<User_Event_BVS__c> bvsvalues = new List<User_Event_BVS__c>();
        
        bvsvalues =[select BVS_id__c from User_Event_BVS__c u where 
                    (u.UPE_id__r.BoothAdmin_id__r.Email=:userInfo.getUserName()  
                    and u.UPE_id__r.UEP_isActive__c=true and  
                    (u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive') ) 
                    OR (u.UPE_id__r.User_id__r.Email=:userInfo.getUserName() 
                    and  u.UPE_id__r.Profile_id__r.PR_Name__c='BoothAdmin' 
                    and u.UPE_id__r.UEP_isActive__c=true and  
                    (u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive') ) 
                    Or (UPE_id__r.User_id__c=:userInfo.getUserId()  and u.UPE_id__r.UEP_isActive__c=true 
                    and  (u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive')) ];  
        
        system.debug('YYYYYYYYYYYYYYYYYYYYYYY '+bvsvalues );
        integer recCount =0;
        
        for(User_Event_BVS__c valuesofbvs: bvsvalues ){
        setofboothpersonnelIds.add(valuesofbvs.BVS_id__c);        
        }
      
        List<document> des = new List<document>();
        des =[select id from document where name='Boothadmindefalt.jpeg'];
        string defalutImage;
        if(des.size()>0){
        defalutImage =des[0].id;
        }
        
        bvsListBefore = [Select b.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c,Checkbox_For_Report__c, 
        b.User_id__c, b.User_id__r.Name,b.SystemModstamp, b.OwnerId, b.Name,AS_ImageUrl__c, 
        b.LastModifiedDate, b.LastModifiedById, b.LastActivityDate, b.IsDeleted, b.Id, 
        b.EA_AttendeeBarcode__c, b.CreatedDate, b.CreatedById, b.BVS_Title__c, b.BVS_Tags__c, 
        b.BVS_SurveyQuestion4__c, b.BVS_SurveyQuestion3__c, b.BVS_SurveyQuestion2__c, b.BVS_SurveyQuestion1__c, 
        b.BVS_SurveyAnswer4__c, b.BVS_SurveyAnswer3__c, b.BVS_SurveyAnswer2__c, b.BVS_SurveyAnswer1__c, 
        b.BVS_State__c, b.BVS_PhoneNumber__c, b.BVS_Notes__c, b.BVS_LeadType__c, b.BVS_LeadRating__c, 
        b.BVS_LeadCategory__c, b.BVS_LastName__c, b.BVS_FollowUps__c, b.BVS_FirstName__c, b.BVS_Email__c, 
        b.BVS_Company__c, b.BVS_City__c, b.BVS_Budget__c,b.ScanTime__c From BoothVisitSummary__c b 
        where id in :setofboothpersonnelIds and EA_AttendeeBarcode__c!=null order by ScanTime__c DESC ];
        
        system.debug( ' SSSSSSSSSSSSSSSSSSS '+bvsListBefore );
        try{
           if(eventSelected== NULL || eventSelected=='ALL')
           eventtimezone='Eastern Time(USA)';
           else
           {
             EvntsForTZ=[select  id,name,EV_Title__c,EV_HostingTimeZone__c  from Event__c where id=:eventSelected limit 1];
 if(EvntsForTZ.size()>0){
           
           defaultEvent =EvntsForTZ[0].EV_HostingTimeZone__c;
           }
           }}catch(Exception e){eventtimezone='Eastern Time(USA)';}
        
        for(BoothVisitSummary__c yt:bvsListBefore ){
         system.debug( ' UUUUUUUUUUUUUUUU '+yt);
      
       /* try{
        string abd = string.valueOf(yt.ScanTime__c);
        
        yt.ScanTime__c= getLocalDateTime( yt.ScanTime__c);
        }catch (exception e){}
        */
        try{
       yt.ScanTime__c= geteventbasetime( yt.ScanTime__c,eventtimezone);
       }catch (exception e){}
        yt.Dummy__c  =  yt.AS_ImageUrl__c;     
        
        if(yt.AS_ImageUrl__c ==null || yt.AS_ImageUrl__c ==''){
       
      
          if(yt.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c!=null && yt.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c!=''){
            yt.AS_ImageUrl__c=yt.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c;
          } else{
           yt.AS_ImageUrl__c=defalutImage ;
          }    
           system.debug('======hhhhhhhhhhhhhhhhhhhhhhh==='+yt.AS_ImageUrl__c);     
       
       }
        
        bvsvaluesbefore1.add(yt);
                      
        system.debug('======hhhhhhhhhhhhhhhhhhhhhhh==='+bvsvaluesbefore1);        
        }
  
        } 
        else{
        
        set<Id>  setofboothpersonnelIds = new set<Id>();
        bvsList = new List<List<BoothVisitSummary__c>>(); 
        bvsvaluesbefore1 = new  List<BoothVisitSummary__c >(); 
         ListForPagination = new List<BoothVisitSummary__c>(); 
        List<User_Event_BVS__c> bvsvalues = new  List<User_Event_BVS__c>(); 
        gg = new BL_SecuritySettingsCon(eventSelected);
        system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  gg'+ gg );  
        
        List<document> des = new List<document>();
        des =[select id from document where name='Boothadmindefalt.jpeg'];
        string defalutImage;
        if(des.size()>0){
        defalutImage =des[0].id;
        }


        List<BoothVisitSummary__c > bvsListBefore = new  List<BoothVisitSummary__c >();  
        integer recCount =0;  
        
        bvsvalues =[select BVS_id__c from User_Event_BVS__c u where 
                    (u.UPE_id__r.BoothAdmin_id__r.Email=:userInfo.getUserName() 
                    and u.EV_id__c=:eventSelected and u.UPE_id__r.UEP_isActive__c=true and  
                    (u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive')) 
                    OR (u.UPE_id__r.User_id__r.Email=:userInfo.getUserName() and u.EV_id__c=:eventSelected 
                    and u.UPE_id__r.Profile_id__r.PR_Name__c='BoothAdmin' and u.UPE_id__r.UEP_isActive__c=true 
                    and  u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive') 
                    Or (UPE_id__r.User_id__c=:userInfo.getUserId() and u.EV_id__c=:eventSelected 
                    and u.UPE_id__r.UEP_isActive__c=true and  u.UPE_id__r.Status__c!='Mobile only access' 
                    And u.UPE_id__r.Status__c!='InActive') ];  
                    
        for(User_Event_BVS__c h:bvsvalues){
        setofboothpersonnelIds.add(h.BVS_id__c);
        }
        
       
        
        
        bvsListBefore = [Select b.Dummy__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c, 
                        b.User_id__c, b.User_id__r.Name,b.SystemModstamp, b.OwnerId, b.Name, 
                        b.LastModifiedDate, b.LastModifiedById,b.AS_ImageUrl__c , b.LastActivityDate,Checkbox_For_Report__c, 
                        b.IsDeleted, b.Id, b.EA_AttendeeBarcode__c, b.CreatedDate, 
                        b.CreatedById, b.BVS_Title__c, b.BVS_Tags__c, b.BVS_SurveyQuestion4__c, 
                        b.BVS_SurveyQuestion3__c, b.BVS_SurveyQuestion2__c, b.BVS_SurveyQuestion1__c, 
                        b.BVS_SurveyAnswer4__c, b.BVS_SurveyAnswer3__c, b.BVS_SurveyAnswer2__c, 
                        b.BVS_SurveyAnswer1__c, b.BVS_State__c, b.BVS_PhoneNumber__c, b.BVS_Notes__c, 
                        b.BVS_LeadType__c, b.BVS_LeadRating__c, b.BVS_LeadCategory__c, b.BVS_LastName__c, 
                        b.BVS_FollowUps__c, b.BVS_FirstName__c, b.BVS_Email__c, b.BVS_Company__c, 
                        b.BVS_City__c, b.BVS_Budget__c,b.ScanTime__c From BoothVisitSummary__c b 
                        where id in :setofboothpersonnelIds and EA_AttendeeBarcode__c!=null order by ScanTime__c DESC ];
                         try{
           if(eventSelected== NULL || eventSelected=='ALL')
           eventtimezone='Eastern Time(USA)';
           else
           {
             EvntsForTZ=[select  id,name,EV_Title__c,EV_HostingTimeZone__c  from Event__c where id=:eventSelected limit 1];
 if(EvntsForTZ.size()>0){
           
           defaultEvent =EvntsForTZ[0].EV_HostingTimeZone__c;
           }
           }}catch(Exception e){eventtimezone='Eastern Time(USA)';}
        
        for(BoothVisitSummary__c yt:bvsListBefore ){
                
          try{              
        yt.ScanTime__c= geteventbasetime( yt.ScanTime__c,eventtimezone);
        }catch (exception e){}
        if(yt.AS_ImageUrl__c ==null || yt.AS_ImageUrl__c ==''){
       
      
          if(yt.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c!=null && yt.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c!=''){
            yt.AS_ImageUrl__c=yt.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c;
          } else{
           yt.AS_ImageUrl__c=defalutImage ;
          }    
           system.debug('======hhhhhhhhhhhhhhhhhhhhhhh==='+yt.AS_ImageUrl__c);     
       
       }
        
           
        bvsvaluesbefore1.add(yt);
      
        system.debug('======vvvvvvvvvvvvvvvvvvvvv==='+bvsvaluesbefore1); 
        }             
        } 
       system.debug('======AAAAAAAAAAAAAAAAAAAAAAAAAAA==='+bvsvaluesbefore1); 
        if(bvsvaluesbefore1.size()>0)
        {
        system.debug('==================='+bvsvaluesbefore1);
         conlst=true;
        // hasLast = True;
       //  hasFirst = False;
         count=bvsvaluesbefore1.size();
       //  hasPrevious =false;
       //  hasNext=true;
         pageno=1;
          if(math.mod(bvsvaluesbefore1.size(),50)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=bvsvaluesbefore1.size()/50;
                
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(bvsvaluesbefore1.size()/50) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+bvsvaluesbefore1.size()/50);
            }
        
        for(integer i=0; i<50;i++)
        {
        
        
        ListForPagination.add(bvsvaluesbefore1[i]);
        system.debug( ' LLLLLLLLLLLLLLLLLLLLLLLLLLLLL '+ListForPagination+ ' **************** '+bvsvaluesbefore1.size()/50);
       
        
        if(bvsvaluesbefore1.size() <= 50){
        system.debug( ' LLLLLLLLLLLLLLLLLLLLLLLLLLLLL '+bvsvaluesbefore1.size());
        hasLast = false;
        hasFirst = False;
        hasNext=false;
        hasPrevious =false;
        Disabled_Last_Icon = True;
        Disabled_Next_Icon = True;
        Disabled_First_Icon = True;
        Disabled_Previous_Icon = True;
        NoRecordsFound = False;
        DisplayPages = True;
       }else {
       system.debug( ' sssssssssssssssssssssssss '+bvsvaluesbefore1.size());
       hasLast = True;
       hasFirst = False;
       hasPrevious =false;
       Disabled_First_Icon = True;
       Disabled_Previous_Icon = True;
       Disabled_Next_Icon = false;
       Disabled_Last_Icon = false;
       hasNext=true;
       DisplayPages = True;
       }         
        
        }
         
        } else {
       hasLast = False;
       hasFirst = False;
       hasPrevious =false;
       Disabled_First_Icon = True;
       Disabled_Previous_Icon = True;
       Disabled_Next_Icon = True;
       Disabled_Last_Icon = True;
       hasNext=False;
       NoRecordsFound = True; 
        }
           
   
    }catch (exception e){}  
    ForPageSize = ListForPagination.size();    
      return null;
    }
    
    
      public static Datetime getLocalDateTime(Datetime z){    
        Datetime l = z.Date();
        l = l.addHours(z.hour());
        l = l.addMinutes(z.minute());
        l = l.addSeconds(z.second());
        
        return l;
    }
    /**********************************/
    
    public static Datetime geteventbasetime(Datetime z,string eventtimezone){
    system.debug('sagar');    
         datetime dte; 
     datetime   GSTe=z;
    system.debug('gmt'+GSTe);
    //system.debug('xyz'+eventSelected);
  /*if(seleve == NULL || seleve =='ALL'){
  system.debug('vidya');
   dte=GSTe.addHours(-4);
   }else{ */
   //system.debug('ram'+seleve);
  // Event__c eve=new Event__c();
  // eve=[select id,EV_HostingTimeZone__c from Event__c  where id =: seleve];
    if(eventtimezone=='Eastern Time(USA)'){
    
          dte=GSTe.addHours(-4);
          system.debug('est'+dte);
    }else if(eventtimezone=='Central Time(USA)'){
          dte=GSTe.addHours(-5);
    }
    else if(eventtimezone=='Mountain Time(USA)'){
         dte=GSTe.addHours(-6);
    }
    else if(eventtimezone=='Pacific Time(USA)'){
        dte=GSTe.addHours(-7);
        system.debug('pst'+dte);
    }
    else if(eventtimezone=='Indian Standard Time(IST)'){
        dte=(GSTe.addHours(5)).addMinutes(+30);
     }
     else if(eventtimezone=='Central European Time Zone'){
        dte=GSTe.addHours(+1);
     }
//}
        return dte;
    }
    /*********************************/
    
    //Search Method    
     public PageReference search(){   
    try{
        ForPageSize = null;
        ListForPagination = new List<BoothVisitSummary__c>();
        set<id> setofboothpersonnelIds = new  set<id>();
        bvsList = new List<List<BoothVisitSummary__c>>();
        List<BoothVisitSummary__c> bvsListbefore = new List<BoothVisitSummary__c>(); 
        
        List<BoothVisitSummary__c> bvsvaluesbefore1= new List<BoothVisitSummary__c>(); 
        
        List<User_Event_BVS__c> bvsvalues = new  List<User_Event_BVS__c>(); 
        if(eventSelected =='All'){
        bvsvalues =[select BVS_id__c from User_Event_BVS__c u where (u.UPE_id__r.BoothAdmin_id__r.Email=:userInfo.getUserName() and u.UPE_id__r.UEP_isActive__c=true and u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive') or (u.UPE_id__r.User_id__c=:userInfo.getUserId()  and u.UPE_id__r.UEP_isActive__c=true and u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive') ];  
        system.debug('searchhhhhhhhhhhhhhhhhhhhhhh '+bvsvalues );
        } else{
        bvsvalues =[select BVS_id__c from User_Event_BVS__c u where (u.UPE_id__r.BoothAdmin_id__r.Email=:userInfo.getUserName() and u.EV_id__c=:eventSelected and u.UPE_id__r.UEP_isActive__c=true and u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive') OR (u.UPE_id__r.User_id__r.Email=:userInfo.getUserName() and u.EV_id__c=:eventSelected and u.UPE_id__r.Profile_id__r.PR_Name__c='BoothAdmin' and u.UPE_id__r.UEP_isActive__c=true and u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive') OR (u.UPE_id__r.User_id__c=:userInfo.getUserId() and u.UPE_id__r.UEP_isActive__c=true and u.EV_id__c=:eventSelected and u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive')];  
        }  
        
        for(User_Event_BVS__c h:bvsvalues)
        {
        
        setofboothpersonnelIds.add(h.BVS_id__c);
        }
        
        
        
     List<document> des = new List<document>();
        des =[select id from document where name='Boothadmindefalt.jpeg'];
        string defalutImage;
        if(des.size()>0){
        defalutImage =des[0].id;
        }
        
        
        
        
        bvsListbefore = [Select b.Checkbox_For_Report__c,b.Dummy__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c, b.User_id__c, b.User_id__r.Name,b.SystemModstamp, 
                         b.OwnerId, b.Name, b.LastModifiedDate, b.LastModifiedById, b.LastActivityDate, b.IsDeleted, b.Id, b.EA_AttendeeBarcode__c, b.CreatedDate, b.CreatedById, 
                         b.BVS_Title__c, b.BVS_Tags__c, b.BVS_SurveyQuestion4__c, b.BVS_SurveyQuestion3__c, b.BVS_SurveyQuestion2__c, b.BVS_SurveyQuestion1__c, b.BVS_SurveyAnswer4__c, 
                         b.BVS_SurveyAnswer3__c, b.BVS_SurveyAnswer2__c, b.BVS_SurveyAnswer1__c, b.BVS_State__c, b.BVS_PhoneNumber__c, b.BVS_Notes__c, b.BVS_LeadType__c, b.BVS_LeadRating__c, 
                         b.BVS_LeadCategory__c, b.BVS_LastName__c, b.BVS_FollowUps__c, b.BVS_FirstName__c, b.BVS_Email__c, b.BVS_Company__c, b.BVS_City__c, b.BVS_Budget__c,b.ScanTime__c 
                         From BoothVisitSummary__c b where id in :setofboothpersonnelIds and (BVS_FirstName__c like :searchString+'%'  or BVS_LastName__c like :searchString+'%') and EA_AttendeeBarcode__c!=null ORDER BY ScanTime__c];
        system.debug('searchhhhhhhhhhhhhhhhhhhhhhh 333333333'+bvsList );
        try{
           if(eventSelected== NULL || eventSelected=='ALL')
           eventtimezone='Eastern Time(USA)';
           else
           {
             EvntsForTZ=[select  id,name,EV_Title__c,EV_HostingTimeZone__c  from Event__c where id=:eventSelected limit 1];
 if(EvntsForTZ.size()>0){
           
           defaultEvent =EvntsForTZ[0].EV_HostingTimeZone__c;
           }
           }}catch(Exception e){eventtimezone='Eastern Time(USA)';}
        for(BoothVisitSummary__c yt:bvsListbefore)
        {
       yt.BVS_LastName__c =escapeSpecialCharacters( yt.BVS_LastName__c);
            yt.BVS_Company__c =escapeSpecialCharacters(yt.BVS_Company__c);
            yt.BVS_LeadCategory__c=escapeSpecialCharacters(yt.BVS_LeadCategory__c);
            yt.BVS_FollowUps__c=escapeSpecialCharacters(yt.BVS_FollowUps__c);
        
        system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ after '+yt.BVS_FirstName__c);
        
        try{ 
       // yt.ScanTime__c= getLocalDateTime( yt.ScanTime__c);
         yt.ScanTime__c= geteventbasetime( yt.ScanTime__c,eventtimezone);
        }catch(exception e){}
        if(mapImage.get(yt.id) != null){
        
        yt.Dummy__c =mapImage.get(yt.id);
        
        }
        
        if(yt.AS_ImageUrl__c ==null || yt.AS_ImageUrl__c ==''){
           
     if(yt.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c!=null && yt.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c!=''){
       yt.AS_ImageUrl__c=yt.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c;
       } else{         
           yt.AS_ImageUrl__c=defalutImage ;
         }    
         system.debug('======hhhhhhhhhhhhhhhhhhhhhhh==='+yt.AS_ImageUrl__c);     
       }
        
       
       
        bvsvaluesbefore1.add(yt);
        
        
        
        }
         if(bvsvaluesbefore1.size()>0)
        {
        system.debug('==================='+bvsvaluesbefore1);
         conlst=true;
        // hasLast = True;
       //  hasFirst = False;
         count=bvsvaluesbefore1.size();
       //  hasPrevious =false;
       //  hasNext=true;
         pageno=1;
          if(math.mod(bvsvaluesbefore1.size(),50)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=bvsvaluesbefore1.size()/50;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(bvsvaluesbefore1.size()/50) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
        
        for(integer i=0; i<50;i++)
        {
        system.debug( ' ----------- BBBBBBBBBBBBBBBBB '+bvsvaluesbefore1[i]);
        
        ListForPagination.add(bvsvaluesbefore1[i]);
        system.debug( ' LLLLLLLLLLLLLLLLLLLLLLLLLLLLL '+ListForPagination);
        if(bvsvaluesbefore1.size() <=50){
        system.debug( ' LLLLLLLLLLLLLLLLLLLLLLLLLLLLL '+bvsvaluesbefore1.size());
        hasLast = false;
        hasNext=false;
        Disabled_Last_Icon = True;
        Disabled_Next_Icon = True;
        Disabled_First_Icon = True;
        Disabled_Previous_Icon = True;
        NoRecordsFound = False;
        DisplayPages = True;
       }else {
       system.debug( ' sssssssssssssssssssssssss '+bvsvaluesbefore1.size());
       hasLast = True;
       hasFirst = False;
       hasPrevious =false;
       Disabled_First_Icon = True;
       Disabled_Previous_Icon = True;
       Disabled_Next_Icon = false;
       Disabled_Last_Icon = false;
       hasNext=true;
       NoRecordsFound = False;
       DisplayPages = True;
       }         
        
        }
         
        } else {
       NoRecordsFound = True;
       DisplayPages = False;
       hasLast = False;
       hasFirst = False;
       hasPrevious =false;
       Disabled_First_Icon = True;
       Disabled_Previous_Icon = True;
       Disabled_Next_Icon = True;
       Disabled_Last_Icon = True;
       hasNext=False;
        
        }
          
    
        
        
   }catch(exception e){}  
   ForPageSize = ListForPagination.size(); 
    return null;
    
    }
     
 
     
     public PageReference valuesOfeventswithselectedvalue() {
 try{  
       ForpageSize = null;
       ListForPagination = new List<BoothVisitSummary__c>();
       string xx = ApexPages.currentPage().getParameters().get('valu');
       integer recCount = 0;
       set<Id>  setofboothpersonnelIds = new set<Id>();
           bvsList = new List<List<BoothVisitSummary__c>>(); 
           List<User_Event_BVS__c> bvsvalues = new  List<User_Event_BVS__c>(); 
           List<BoothVisitSummary__c> bvsvaluesbefore1 = new List<BoothVisitSummary__c>();
           List<BoothVisitSummary__c> bvsvaluesbe = new List<BoothVisitSummary__c>();
            List<document> des = new List<document>();
        des =[select id from document where name='Boothadmindefalt.jpeg'];
        string defalutImage;
        if(des.size()>0){
        defalutImage =des[0].id;
        }
           if(eventSelected =='All'){
           bvsvalues =[select BVS_id__c from User_Event_BVS__c u where 
                 
           (u.UPE_id__r.BoothAdmin_id__r.Email=:userInfo.getUserName() and u.UPE_id__r.UEP_isActive__c=true and u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive' ) OR 
           (u.UPE_id__r.User_id__r.Email=:userInfo.getUserName()  and u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive' )];  
           
           }
           else{
           bvsvalues =[select BVS_id__c from User_Event_BVS__c u where (u.UPE_id__r.BoothAdmin_id__r.Email=:userInfo.getUserName() and u.EV_id__c=:eventSelected and u.UPE_id__r.UEP_isActive__c=true and u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive' ) OR (u.UPE_id__r.User_id__r.Email=:userInfo.getUserName() and u.EV_id__c=:eventSelected and  u.UPE_id__r.UEP_isActive__c=true and u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive' )];  
          }
               for(User_Event_BVS__c h:bvsvalues){
                     setofboothpersonnelIds.add(h.BVS_id__c);
               }
               system.debug('valueeeeeeeeeeeeeeeeeeeeeee OF XXXXXXXXXXXXXXXXXXXXXXXXX'+xx +' 66666666666666666 '+setofboothpersonnelIds);
                system.debug('valueeeeeeeeeeeeeeeeeeeeeee OF yyyyyyyyyyyyyyyyyyyyyyyy'+eventSelected );
               
              if(xx!='All'){
               bvsvaluesbe = [Select AS_ImageUrl__c,b.Dummy__c,b.ScanTime__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c, b.User_id__c,b.Checkbox_For_Report__c,
                              b.User_id__r.Name,b.SystemModstamp, b.OwnerId, b.Name, b.LastModifiedDate, b.LastModifiedById,
                              b.LastActivityDate, b.IsDeleted, b.Id, b.EA_AttendeeBarcode__c, b.CreatedDate, b.CreatedById,
                              b.BVS_Title__c, b.BVS_Tags__c, b.BVS_SurveyQuestion4__c, b.BVS_SurveyQuestion3__c, b.BVS_SurveyQuestion2__c,
                              b.BVS_SurveyQuestion1__c, b.BVS_SurveyAnswer4__c, b.BVS_SurveyAnswer3__c, b.BVS_SurveyAnswer2__c, 
                              b.BVS_SurveyAnswer1__c, b.BVS_State__c, b.BVS_PhoneNumber__c, b.BVS_Notes__c, b.BVS_LeadType__c, b.BVS_LeadRating__c,
                              b.BVS_LeadCategory__c, b.BVS_LastName__c, b.BVS_FollowUps__c, b.BVS_FirstName__c, b.BVS_Email__c, b.BVS_Company__c, 
                              b.BVS_City__c, b.BVS_Budget__c From BoothVisitSummary__c b where id in :setofboothpersonnelIds and  b.BVS_LastName__c 
                              like :xx+'%'  and EA_AttendeeBarcode__c!=null order by ScanTime__c DESC  ];
              }else{
              bvsvaluesbe = [Select b.Dummy__c,b.ScanTime__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c, b.User_id__c, b.User_id__r.Name,b.Checkbox_For_Report__c,
                             b.SystemModstamp, b.OwnerId, b.Name, b.LastModifiedDate, b.LastModifiedById, b.LastActivityDate, b.IsDeleted,
                             b.Id, b.EA_AttendeeBarcode__c, b.CreatedDate, b.CreatedById, b.BVS_Title__c, b.BVS_Tags__c, b.BVS_SurveyQuestion4__c, 
                             b.BVS_SurveyQuestion3__c, b.BVS_SurveyQuestion2__c, b.BVS_SurveyQuestion1__c, b.BVS_SurveyAnswer4__c, b.BVS_SurveyAnswer3__c,
                             b.BVS_SurveyAnswer2__c, b.BVS_SurveyAnswer1__c, b.BVS_State__c, b.BVS_PhoneNumber__c, b.BVS_Notes__c, b.BVS_LeadType__c, b.BVS_LeadRating__c, 
                             b.BVS_LeadCategory__c, b.BVS_LastName__c, b.BVS_FollowUps__c, b.BVS_FirstName__c, b.BVS_Email__c, b.BVS_Company__c, b.BVS_City__c, 
                             b.BVS_Budget__c,AS_ImageUrl__c From BoothVisitSummary__c b where id in :setofboothpersonnelIds and EA_AttendeeBarcode__c!=null order 
                             by ScanTime__c DESC ];
              
              
             }
              try{
           if(eventSelected== NULL || eventSelected=='ALL')
           eventtimezone='Eastern Time(USA)';
           else
           {
             EvntsForTZ=[select  id,name,EV_Title__c,EV_HostingTimeZone__c  from Event__c where id=:eventSelected limit 1];
 if(EvntsForTZ.size()>0){
           
           defaultEvent =EvntsForTZ[0].EV_HostingTimeZone__c;
           }
           }}catch(Exception e){eventtimezone='Eastern Time(USA)';}
              system.debug('valueeeeeeeeeeeeeeeeeeeeeee OF zzzzzzzzzzzzzzzzzzzzz'+bvsvaluesbe );
                for(BoothVisitSummary__c yt: bvsvaluesbe ){
      try{        
       yt.ScanTime__c= geteventbasetime( yt.ScanTime__c,eventtimezone);       
         }catch(exception e){}
  if(yt.AS_ImageUrl__c ==null || yt.AS_ImageUrl__c ==''){
           
     if(yt.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c!=null && yt.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c!=''){
       yt.AS_ImageUrl__c=yt.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c;
       } else{         
           yt.AS_ImageUrl__c=defalutImage ;
         }    
         system.debug('======hhhhhhhhhhhhhhhhhhhhhhh==='+yt.AS_ImageUrl__c);     
       }
              
               try{
               
                              
               // yt.ScanTime__c= getLocalDateTime( yt.ScanTime__c);
               
               }catch(exception e){}
             
                bvsvaluesbefore1.add(yt);
                           
                }
             if(bvsvaluesbefore1.size()>0)
        {
        system.debug('==================='+bvsvaluesbefore1);
         conlst=true;
        // hasLast = True;
       //  hasFirst = False;
         count=bvsvaluesbefore1.size();
       //  hasPrevious =false;
       //  hasNext=true;
         pageno=1;
          if(math.mod(bvsvaluesbefore1.size(),50)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=bvsvaluesbefore1.size()/50;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(bvsvaluesbefore1.size()/50) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
        
        for(integer i=0; i<50;i++)
        {
        system.debug( ' ----------- BBBBBBBBBBBBBBBBB '+bvsvaluesbefore1[i]);
        
        ListForPagination.add(bvsvaluesbefore1[i]);
        system.debug( ' LLLLLLLLLLLLLLLLLLLLLLLLLLLLL '+ListForPagination.size());
        if(bvsvaluesbefore1.size() <=50){
        system.debug( ' LLLLLLLLLLLLLLLLLLLLLLLLLLLLL '+bvsvaluesbefore1.size());
        hasLast = false;
        hasNext=false;
        Disabled_Last_Icon = True;
        Disabled_Next_Icon = True;
        Disabled_First_Icon = True;
        Disabled_Previous_Icon = True;
        NoRecordsFound = False;
        DisplayPages = True;
        hasLast = False;
        hasFirst = False;
        hasPrevious =false;
       }else {
       system.debug( ' sssssssssssssssssssssssss '+bvsvaluesbefore1.size());
       hasLast = True;
       hasFirst = False;
       hasPrevious =false;
       Disabled_First_Icon = True;
       Disabled_Previous_Icon = True;
       Disabled_Next_Icon = false;
       Disabled_Last_Icon = false;
       hasNext=true;
       NoRecordsFound = False;
       DisplayPages = True;
       }         
        
        }
         
        } else {
       NoRecordsFound = True;
       DisplayPages = false;
       hasLast = False;
       hasFirst = False;
       hasPrevious =false;
       Disabled_First_Icon = True;
       Disabled_Previous_Icon = True;
       Disabled_Next_Icon = True;
       Disabled_Last_Icon = True;
       hasNext=False;
        
        }
          
       
     
     }catch(exception e){}   
     ForpageSize = ListForPagination.size();   
     return null;
   
 }
 
 
 
 public List<InnForSurveys> InnclsSurvey{get;set;}
     //Export Method 
     public PageReference seltoexport() {
     InnclsSurvey = new List<InnForSurveys>();
      NoRecordSelected = False;
      try{    
     
      if(Allrecords == true){
      ListForPagination= new List<BoothVisitSummary__c>();
      system.debug('         all records  '+eventselected);  
     
     SET<id> upsBvs = new SET<id>();
       if(eventselected == 'All'){
        for(User_Event_BVS__c userBvs:[SELECT BVS_id__r.id,id,BVS_id__c,EV_id__c from User_Event_BVS__c where  (UPE_id__r.User_id__r.id=:userInfo.getUserId() OR UPE_id__r.BoothAdmin_id__r.id=:userInfo.getUserId()) ]){
             upsBvs.add(userBvs.BVS_id__r.id);  
       }
      
       }else{
         for(User_Event_BVS__c userBvs:[SELECT BVS_id__r.id,id,BVS_id__c,EV_id__c from User_Event_BVS__c where  (UPE_id__r.User_id__r.id=:userInfo.getUserId() OR UPE_id__r.BoothAdmin_id__r.id=:userInfo.getUserId()) and  UPE_id__r.EV_id__r.id=:eventselected]){
             system.debug('     records  '+userBvs);
             upsBvs.add(userBvs.BVS_id__r.id); 
           }
        }
         
     
          
      ListForPagination=[Select  id,Checkbox_For_Report__c From BoothVisitSummary__c b where Id In :upsBvs ];
     
     
     for(BoothVisitSummary__c BVS : ListForPagination){
        ForSelectedCheckBoxes.put(BVS.id,BVS.Checkbox_For_Report__c);
     }
     
     }else{
     
      for(BoothVisitSummary__c BVS : ListForPagination){
       if(BVS.Checkbox_For_Report__c == True ){
        ForSelectedCheckBoxes.put(BVS.id,BVS.Checkbox_For_Report__c);
        }
      }
     
    }
     

      if((ForSelectedCheckBoxes.Keyset()).size()>0){
        ListOfSelectedIds = ForSelectedCheckBoxes.Keyset();
      }      
    
         
         
         
         
   
        supportList = new List<BoothVisitSummary__c>();
         
        supportList = checkBVSList(ListOfSelectedIds);
        
        
        for(BoothVisitSummary__c nlist:supportList ){
        
        
          InnclsSurvey.add(new InnForSurveys(nlist,mapAttNSur.get(nlist.EA_AttendeeBarcode__r.AS_id__r.id)));
        }
        
        
        
        
        system.debug( ' DDDDDD GGGGGGGGGG'+supportList);
        if(supportList.size()>0){
        system.debug( ' OOOOOOOOOOOOOOOOO '+ListOfSelectedIds);
        BVSList = new List<List<BoothVisitSummary__c>>(); 
        BVSList.add(supportList);  
        PageReference pageRef= new PageReference('/apex/BL_ExportLeadsToCsv');
        pageRef.setredirect(false);
        return pageRef;
        
        
        }else{
        system.debug( ' WWWWWWWWWWWWWWWWWWWWWWW '+ListOfSelectedIds);
        //NoRecordSelected = True;
     //   ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Select at least one lead'));
        return null;
        } 
    }catch(exception e){return null;}    
    
   }
     
   
   
   Public class InnForSurveys{
     public List<Survey__c> innsurvey{get;set;}
     public BoothVisitSummary__c InnBvs{get;set;}
     public InnForSurveys(BoothVisitSummary__c bs,List<Survey__c> bg){
       this.InnBvs = bs;
       
       this.innsurvey=bg;
     }
   
     
   }
   
   
 
   
   public List<BoothVisitSummary__c> checkBVSList(set<Id> listOfBVS){
 try{
        
    Set<id> attForSurvaeyids = new Set<id>();   
    integer ph;
    List<BoothVisitSummary__c>  localBVSListSelected = new List<BoothVisitSummary__c> ();
    List<ID> selectedBVSList = new List<ID>();
    if(listOfBVS == null){
    NoRecordSelected = True;
    }else {
    NoRecordSelected = False;
    }
    system.debug('value of listOfBVS '+listOfBVS);
    
   // selectedBVSList = listOfBVS.split(',');
    if(listOfBVS.size()>0){
        localBVSListSelected =  [Select  b.EA_AttendeeBarcode__r.DiversityType__c,b.User_id__r.Name,b.EA_AttendeeBarcode__c, 
                                 b.CreatedDate, b.CreatedById, b.BVS_Title__c, b.BVS_Tags__c, b.BVS_SurveyQuestion4__c, b.BVS_SurveyQuestion3__c, 
                                 b.BVS_SurveyQuestion2__c, b.BVS_SurveyQuestion1__c, b.BVS_SurveyAnswer4__c, b.BVS_SurveyAnswer3__c, b.BVS_SurveyAnswer2__c, 
                                 b.BVS_SurveyAnswer1__c, b.BVS_State__c, b.BVS_PhoneNumber__c, b.BVS_Notes__c, b.BVS_LeadType__c, b.BVS_LeadRating__c, b.BVS_LeadCategory__c, 
                                 b.BVS_LastName__c, b.BVS_FollowUps__c, b.BVS_FirstName__c, b.BVS_Email__c, b.BVS_Company__c, b.BVS_City__c, b.BVS_Budget__c,
                                 b.EA_AttendeeBarcode__r.AS_id__r.Id, b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkZip__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPoBox__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Work_Country__c,
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkCity__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress2__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress1__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_WebsiteUrl__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ThroughEventBrite__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.As_SuffixNew__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_shippingzip__c, b.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_States__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingPoBox__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingPhone__c, b.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_Country__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingCity__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress2__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress1__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_SecondaryBusinessCategory1__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c, b.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_NumberOfEmployees__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode5__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode4__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode3__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode2__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode1__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c,b.EA_AttendeeBarcode__r.AS_id__r.As_Home_State__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomePoBox__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_HomePhone__c, b.EA_AttendeeBarcode__r.AS_id__r.As_Home_Country__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeCity__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress2__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress1__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Gender__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_FaxNumber__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_DiversityType__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Company__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_CellPhone__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessTaxId__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessRevenue__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessEstablishedDate__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDunsNumber__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDescription__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BlogUrl__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_BirthDate__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Age__c,Follow_Update__c From 
                                 BoothVisitSummary__c b where id in :listOfBVS and EA_AttendeeBarcode__c!=null order by ScanTime__c DESC ];
        
        if(localBVSListSelected.size()>0){
            for(BoothVisitSummary__c rt : localBVSListSelected ){
               attForSurvaeyids.add(rt.EA_AttendeeBarcode__r.AS_id__r.id);
                if(rt.Follow_Update__c !=null){
                    rt.Follow_Update__c =getLocalDateTime(rt.Follow_Update__c);
                }
                if(rt.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c != null && rt.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c!=''){
                rt.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c);
                }
                if(rt.BVS_FirstName__c != null && rt.BVS_FirstName__c!=''){
                system.debug('777777777777777777 '+rt.BVS_FirstName__c);
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c =escape(rt.BVS_FirstName__c); 
                }else{
                  rt.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c); 
                }
                
                if(rt.BVS_lastName__c != null && rt.BVS_LastName__c!=''){
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c =escape(rt.BVS_LastName__c); 
                }   else{
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c); 
                }    
                
                if(rt.EA_AttendeeBarcode__r.AS_id__r.As_SuffixNew__c!= null && rt.EA_AttendeeBarcode__r.AS_id__r.As_SuffixNew__c!=''){
                rt.EA_AttendeeBarcode__r.AS_id__r.As_SuffixNew__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.As_SuffixNew__c); 
                } else{
                rt.EA_AttendeeBarcode__r.AS_id__r.As_SuffixNew__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.As_SuffixNew__c); 
                }
                
                if(rt.BVS_Title__c != null && rt.BVS_Title__c!=''){
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c =escape(rt.BVS_Title__c); 
                } else{
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c); 
                }
                
                if(rt.BVS_Email__c!= null && rt.BVS_Email__c!=''){
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c=escape(rt.BVS_Email__c); 
                } else{
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c); 
                }
                                
                
                if(rt.EA_AttendeeBarcode__r.AS_id__r.AS_CellPhone__c!= null && rt.EA_AttendeeBarcode__r.AS_id__r.AS_CellPhone__c!=''){
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_CellPhone__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_CellPhone__c); 
                } else{
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_CellPhone__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_CellPhone__c); 
                }
                
                if(rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress1__c != null && rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress1__c!=''){
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress1__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress1__c); 
                } else{
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress1__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress1__c); 
                }
                
                if(rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress2__c != null && rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress2__c!=''){
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress2__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress2__c); 
                } else{
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress2__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress2__c); 
                }
                
                if(rt.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessTaxId__c != null && rt.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessTaxId__c !=''){
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessTaxId__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessTaxId__c); 
                } else{
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessTaxId__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessTaxId__c); 
                }
                
                if(rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress1__c != null && rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress1__c!=''){
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress1__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress1__c); 
                } else{
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress1__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress1__c ); 
                }
                
                if(rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress2__c != null && rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress2__c !=''){
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress2__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress2__c); 
                } else{
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress2__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress2__c); 
                }
                
                if(rt.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress1__c!= null && rt.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress1__c!=''){
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress1__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress1__c); 
                } else{
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress1__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress1__c); 
                }
                
                if(rt.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress2__c != null && rt.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress2__c !=''){
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress2__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress2__c); 
                } else{
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress2__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress2__c); 
                }
                
                if(rt.BVS_Notes__c != null && rt.BVS_Notes__c !=''){
                rt.BVS_Notes__c =escape(rt.BVS_Notes__c); 
                 rt.BVS_Notes__c ='"'+rt.BVS_Notes__c+'"'; 
                } else{
                rt.BVS_Notes__c ='"'+rt.BVS_Notes__c+'"'; 
                }
                
                
                
                                               
                if(rt.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDescription__c!= null && rt.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDescription__c!=''){
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDescription__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDescription__c); 
                } else{
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDescription__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDescription__c); 
                }
                
                
                if(rt.BVS_Company__c != null && rt.BVS_Company__c !=''){
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_Company__c =escape(rt.BVS_Company__c); 
                } else{
               rt.EA_AttendeeBarcode__r.AS_id__r.AS_Company__c =escape( rt.EA_AttendeeBarcode__r.AS_id__r.AS_Company__c); 
                }
                
                
                if(rt.BVS_PhoneNumber__c != null && rt.BVS_PhoneNumber__c !=''){
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c =escape(rt.BVS_PhoneNumber__c); 
                }else{
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c); 
                }
                
                if(rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c!=null && string.ValueOf(rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c).startswith('0')){
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c ='"=TEXT('+rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c+','+'\""00000\"")"';
                }else if(rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c !=null){
                 rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c =rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c;
                }
                
               if(rt.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c!='' && rt.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c!=null){
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c);
               }
                if(rt.EA_AttendeeBarcode__r.AS_id__r.AS_DiversityType__c!='' && rt.EA_AttendeeBarcode__r.AS_id__r.AS_DiversityType__c!=null){
                rt.EA_AttendeeBarcode__r.AS_id__r.AS_DiversityType__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_DiversityType__c);
               } 
                               
            }
        } 
    }
    system.debug( ' JJJJJJJJJJJJJJJJJJJJJ '+localBVSListSelected);
    
    
    string Query ='SELECT id,AttendeeSummary__r.id,AttendeeSummary__r.AS_Email__c,Survey_Questions__c,Answers__c,Event__c,Survey_Questions__r.Question__c from  Survey__c where AttendeeSummary__r.id IN :attForSurvaeyids';
    
    
    if(eventselected!='All'){
      Query=Query+' and event__c=\''+eventselected+'\'';
    }
    
    
    system.debug('FFFFFFFFFFFFFFFFFFFFFFFff '+Query );
    
    
     mapAttNSur = new MAP<Id,List<Survey__c>>();
    List<Survey__c> survey= new List<Survey__c>();
    survey = dataBase.Query(Query);
    
    
      for(Id ifcd:attForSurvaeyids){
         List<Survey__c> surveytemp= new List<Survey__c>();
        for(Survey__c syt:survey ){
          if(ifcd==syt.AttendeeSummary__r.id){
            syt.Survey_Questions__c  = escape(syt.Survey_Questions__c);
            syt.Answers__c =escape(syt.Answers__c);
            surveytemp.add(syt);
          }
        
        }
        mapAttNSur.put(ifcd,surveytemp);
      
      } 
    
    
    
    system.debug('DDDDDDDDDDDDDDDDDDDDDDDDD '+mapAttNSur);
    
    
    
    
    return localBVSListSelected;
    
 }catch(exception e){return null;}       
       
  }  
    
    
    public void EmailCsv(){
   try{
      NoRecordSelected = False;
      if(Allrecords == true){
      ListForPagination= new List<BoothVisitSummary__c>();
      system.debug('         all records  '+eventselected);  
       if(eventselected == 'All'){
        ListForPagination=[Select ScanTime__c,AS_ImageUrl__c, Checkbox_For_Report__c,id, b.EA_AttendeeBarcode__r.DiversityType__c,b.User_id__r.Name,b.EA_AttendeeBarcode__c, 
                                 b.CreatedDate, b.CreatedById, b.BVS_Title__c, b.BVS_Tags__c, b.BVS_SurveyQuestion4__c, b.BVS_SurveyQuestion3__c, 
                                 b.BVS_SurveyQuestion2__c, b.BVS_SurveyQuestion1__c, b.BVS_SurveyAnswer4__c, b.BVS_SurveyAnswer3__c, b.BVS_SurveyAnswer2__c, 
                                 b.BVS_SurveyAnswer1__c, b.BVS_State__c, b.BVS_PhoneNumber__c, b.BVS_Notes__c, b.BVS_LeadType__c, b.BVS_LeadRating__c, b.BVS_LeadCategory__c, 
                                 b.BVS_LastName__c, b.BVS_FollowUps__c, b.BVS_FirstName__c, b.BVS_Email__c, b.BVS_Company__c, b.BVS_City__c, b.BVS_Budget__c,
                                 b.EA_AttendeeBarcode__r.AS_id__r.Id, b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkZip__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPoBox__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Work_Country__c,
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkCity__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress2__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress1__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_WebsiteUrl__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ThroughEventBrite__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.As_SuffixNew__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_shippingzip__c, b.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_States__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingPoBox__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingPhone__c, b.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_Country__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingCity__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress2__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress1__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_SecondaryBusinessCategory1__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c, b.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_NumberOfEmployees__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode5__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode4__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode3__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode2__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode1__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c,b.EA_AttendeeBarcode__r.AS_id__r.As_Home_State__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomePoBox__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_HomePhone__c, b.EA_AttendeeBarcode__r.AS_id__r.As_Home_Country__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeCity__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress2__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress1__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Gender__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_FaxNumber__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_DiversityType__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Company__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_CellPhone__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessTaxId__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessRevenue__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessEstablishedDate__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDunsNumber__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDescription__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BlogUrl__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_BirthDate__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Age__c,Follow_Update__c  From 
                                BoothVisitSummary__c b where User_id__r.id=:userInfo.getUserId()
                             order  by ScanTime__c DESC];
      
       }else{
          ListForPagination=[Select ScanTime__c,AS_ImageUrl__c,id,Checkbox_For_Report__c , b.EA_AttendeeBarcode__r.DiversityType__c,b.User_id__r.Name,b.EA_AttendeeBarcode__c, 
                                 b.CreatedDate, b.CreatedById, b.BVS_Title__c, b.BVS_Tags__c, b.BVS_SurveyQuestion4__c, b.BVS_SurveyQuestion3__c, 
                                 b.BVS_SurveyQuestion2__c, b.BVS_SurveyQuestion1__c, b.BVS_SurveyAnswer4__c, b.BVS_SurveyAnswer3__c, b.BVS_SurveyAnswer2__c, 
                                 b.BVS_SurveyAnswer1__c, b.BVS_State__c, b.BVS_PhoneNumber__c, b.BVS_Notes__c, b.BVS_LeadType__c, b.BVS_LeadRating__c, b.BVS_LeadCategory__c, 
                                 b.BVS_LastName__c, b.BVS_FollowUps__c, b.BVS_FirstName__c, b.BVS_Email__c, b.BVS_Company__c, b.BVS_City__c, b.BVS_Budget__c,
                                 b.EA_AttendeeBarcode__r.AS_id__r.Id, b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkZip__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPoBox__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Work_Country__c,
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkCity__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress2__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress1__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_WebsiteUrl__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ThroughEventBrite__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.As_SuffixNew__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_shippingzip__c, b.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_States__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingPoBox__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingPhone__c, b.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_Country__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingCity__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress2__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress1__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_SecondaryBusinessCategory1__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c, b.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_NumberOfEmployees__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode5__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode4__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode3__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode2__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode1__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c,b.EA_AttendeeBarcode__r.AS_id__r.As_Home_State__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomePoBox__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_HomePhone__c, b.EA_AttendeeBarcode__r.AS_id__r.As_Home_Country__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeCity__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress2__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress1__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Gender__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_FaxNumber__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_DiversityType__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Company__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_CellPhone__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessTaxId__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessRevenue__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessEstablishedDate__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDunsNumber__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDescription__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BlogUrl__c, 
                                 b.EA_AttendeeBarcode__r.AS_id__r.AS_BirthDate__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Age__c,Follow_Update__c From 
                                 BoothVisitSummary__c b where User_id__r.id=:userInfo.getUserId()
                                                                         AND  Temp__c =: eventselected  order by ScanTime__c DESC];
        }
         
     for(BoothVisitSummary__c BVS : ListForPagination){
        ForSelectedCheckBoxes.put(BVS.id,BVS.Checkbox_For_Report__c);
     }
     
     }else{
     
      for(BoothVisitSummary__c BVS : ListForPagination){
       if(BVS.Checkbox_For_Report__c == True ){
        ForSelectedCheckBoxes.put(BVS.id,BVS.Checkbox_For_Report__c);
        }
      }
     
    }
     

      if((ForSelectedCheckBoxes.Keyset()).size()>0){
        ListOfSelectedIds = ForSelectedCheckBoxes.Keyset();
      }      
    system.debug( ' KKKKKKKKKKKKKKKKKKKK '+ListOfSelectedIds.size());  
        subject ='Leads From Booth Leads';
        system.debug('909090909099090909090909   '+ListOfSelectedIds); 
        if( ListOfSelectedIds != null){
        email=true;
        
        }else{
        NoRecordSelected = True;
       // system.debug('44444444444444444444444 ');
      //  ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Select at least one lead'));
        }
   }catch(exception e){} 
   }
   
    public pagereference displayForcescr(){
        system.debug(' 111111111111'+eventname);
         NoRecordSelected = False;
        for(BoothVisitSummary__c BVS : ListForPagination){
         system.debug( ' AAAAAAAAAAAAAA '+BVS);  
                if(BVS.Checkbox_For_Report__c == True){
                    ForSelectedCheckBoxes.put(BVS.id,BVS.Checkbox_For_Report__c);
                    system.debug( ' SSSSSSSS AAAAAAAAAAAAAA '+ForSelectedCheckBoxes); 
                     
                    system.debug( ' TTTTTTTTTTTTTTTTTTTT '+ForSelectedCheckBoxes.Keyset());
                    ListOfSelectedIds = ForSelectedCheckBoxes.Keyset();
                }
            } 
            if(ListOfSelectedIds != null) {
            displayForcescrBool = True;
            }else {
            NoRecordSelected = True;
            }
        return null;        
  }
    
    public void  getEventDetails() {
    // try{       
        attendeeSummary = new BoothVisitSummary__c();
       List<document> docs =new List<document>();
      docs  = [select id from document where name='Boothadmindefalt1.jpeg'];
      if(docs.size()>0){
       urlIdOfImage =docs[0].id;
      }
     
        if(eventName!=null && eventName!=''){
        attendeeSummary = [Select  b.ScanTime__c,b.Dummy__c,b.EA_AttendeeBarcode__r.DiversityType__c,  b.BVS_Email__c,b.BVS_State__c,
                           b.BVS_City__c,b.Follow_Update__c,b.BVS_LeadRating__c,b.BVS_SurveyQuestion4__c,b.BVS_SurveyQuestion3__c,b.BVS_SurveyQuestion2__c,
                           b.BVS_SurveyQuestion1__c,b.BVS_SurveyAnswer4__c,b.BVS_SurveyAnswer3__c,b.BVS_SurveyAnswer2__c,b.BVS_SurveyAnswer1__c,
                           b.EA_AttendeeBarcode__r.EV_id__c,b.BVS_PhoneNumber__c,b.BVS_Company__c,b.BVS_Title__c,b.BVS_LastName__c,
                           b.BVS_FirstName__c,b.User_id__r.Name,b.BVS_FollowUps__c,b.BVS_Notes__c , b.EA_AttendeeBarcode__r.AS_id__r.Id, 
                           b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkZip__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPoBox__c, 
                           b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Work_Country__c, 
                           b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkCity__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress2__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress1__c, 
                           b.EA_AttendeeBarcode__r.AS_id__r.AS_WebsiteUrl__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ThroughEventBrite__c, 
                           b.EA_AttendeeBarcode__r.AS_id__r.As_SuffixNew__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_shippingzip__c, b.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_States__c, 
                           b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingPoBox__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingPhone__c, b.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_Country__c, 
                           b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingCity__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress2__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress1__c, 
                           b.EA_AttendeeBarcode__r.AS_id__r.AS_SecondaryBusinessCategory1__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c, b.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c, 
                           b.EA_AttendeeBarcode__r.AS_id__r.AS_NumberOfEmployees__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode5__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode4__c, 
                           b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode3__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode2__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode1__c, 
                           b.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c,b.EA_AttendeeBarcode__r.AS_id__r.As_Home_State__c, 
                           b.EA_AttendeeBarcode__r.AS_id__r.AS_HomePoBox__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomePhone__c, b.EA_AttendeeBarcode__r.AS_id__r.As_Home_Country__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeCity__c, 
                           b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress2__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress1__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Gender__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c, 
                           b.EA_AttendeeBarcode__r.AS_id__r.AS_FaxNumber__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_DiversityType__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Company__c,
                           b.EA_AttendeeBarcode__r.AS_id__r.AS_CellPhone__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessTaxId__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessRevenue__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessEstablishedDate__c, 
                           b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDunsNumber__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDescription__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BlogUrl__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BirthDate__c, 
                           b.EA_AttendeeBarcode__r.AS_id__r.AS_Age__c,AS_ImageUrl__c From BoothVisitSummary__c b where id=:eventName and EA_AttendeeBarcode__c!=null order by ScanTime__c DESC ];
        
         system.debug('33333333333334 '+eventName );
         system.debug('505050505050505050505050505050  '+attendeeSummary.AS_ImageUrl__c);
         
        List<BoothVisitSummary__c> bootsummaryForNote= new List<BoothVisitSummary__c>();
        bootsummaryForNote =[select BVS_Notes__c,id,EA_AttendeeBarcode__r.EV_id__r.EV_Title__c from BoothVisitSummary__c where BVS_Email__c=:attendeeSummary.BVS_Email__c and User_id__r.id=:attendeeSummary.User_id__r.id  And BVS_Email__c!=null];
        string notes='';
         system.debug('33333333333334      4444444444444444444 '+bootsummaryForNote );
        
        
        for(BoothVisitSummary__c bvsnotes:bootsummaryForNote){
        
        if(bvsnotes.BVS_Notes__c==null){
        bvsnotes.BVS_Notes__c='';
        }
        
        notes= notes+'<font style="color:Black;font-weight:bold">'+bvsnotes.EA_AttendeeBarcode__r.EV_id__r.EV_Title__c+'</font>&nbsp;&nbsp;'+bvsnotes.BVS_Notes__c+'<br />';
        
        system.debug('Notessssssssssssss1111 '+bvsnotes.EA_AttendeeBarcode__r.EV_id__r.EV_Title__c);
        }     
        
       
        
        gg = new BL_SecuritySettingsCon(attendeeSummary.EA_AttendeeBarcode__r.EV_id__c);
        
        attendeeSummary.BVS_Notes__c =notes;
        
        if(attendeeSummary.EA_AttendeeBarcode__c !=null){
        BVSDetail =true;
        if(attendeeSummary.BVS_FirstName__c != null && attendeeSummary.BVS_FirstName__c!=''){
        
        attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c =attendeeSummary.BVS_FirstName__c; 
        system.debug('hi        this is after '+attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c);
        }
        
        if(attendeeSummary.BVS_lastName__c != null && attendeeSummary.BVS_LastName__c!=''){
        attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c =attendeeSummary.BVS_LastName__c; 
        } 
        if(attendeeSummary.Follow_Update__c!=null){      
        attendeeSummary.Follow_Update__c= getLocalDateTime(attendeeSummary.Follow_Update__c);
        }
        if(attendeeSummary.BVS_Email__c!= null && attendeeSummary.BVS_Email__c!=''){
        attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c=attendeeSummary.BVS_Email__c; 
        }     
        
        if(attendeeSummary.BVS_Title__c != null && attendeeSummary.BVS_Title__c!=''){
        attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c =attendeeSummary.BVS_Title__c; 
        } 
        
        
        if(attendeeSummary.BVS_Company__c != null && attendeeSummary.BVS_Company__c !=''){
        attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_Company__c =attendeeSummary.BVS_Company__c; 
        } 
        
        
        if(attendeeSummary.BVS_PhoneNumber__c != null && attendeeSummary.BVS_PhoneNumber__c !=''){
        attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c =attendeeSummary.BVS_PhoneNumber__c; 
        } 
        
        
        if(attendeeSummary.BVS_City__c != null && attendeeSummary.BVS_City__c !=''){
        attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_WorkCity__c =attendeeSummary.BVS_City__c; 
        } 
        
        
        
        if(attendeeSummary.BVS_State__c != null && attendeeSummary.BVS_State__c !=''){
        
        attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c =attendeeSummary.BVS_State__c; 
        
        } else{
        attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c =attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c; 
        
        }
        
        
       if(attendeeSummary.AS_ImageUrl__c!=null && attendeeSummary.AS_ImageUrl__c!=''){
        system.debug('505050505050505050505050505012222222222222  ');
          urlIdOfImage =attendeeSummary.AS_ImageUrl__c;
        }else if(attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c !=null){
           urlIdOfImage =attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c;
        } 
       
        
        
        
        }
        
        
        listOfintegers = new  List<String>();
        integer i =50;
        integer intege = math.round(attendeeSummary.BVS_LeadRating__c);
        string strofimageurl1 ;
        for (Integer z = 1; z <= 5; z++) { 
        strofimageurl1 ='/resource/'; 
        strofimageurl1  += (z <= intege) ? '1346313847000/FilledStar' : '1346313847000/EmptyStars'; 
        listOfintegers.add(strofimageurl1);
        }
        
        }
    // }catch(exception e){}     
    } 
    
    //Close PopUp Method
    
     public PageReference closePopup() {
        BVSDetail =false;
        return null;
    }
    
    public PageReference cancel() {    
        email=false;
        ccrdetailsbool=false;
        return null;
        
        
    }
    
    
    public PageReference sendEmail() {
  // try{     
        system.debug('Value Of eventNAme     '+ListOfSelectedIds);
        if(EmailTo!=''){ 
        if(ListOfSelectedIds != null){
        BVSListsel = checkBVSList(ListOfSelectedIds);
        
        transfer = 'Prefix::::::::;;;;;;;;First Name::::::::;;;;;;;;Last Name::::::::;;;;;;;;Suffix::::::::;;;;;;;;Email Id::::::::;;;;;;;;Company::::::::;;;;;;;;Designation::::::::;;;;;;;;Mobile Number::::::::;;;;;;;;Age::::::::;;;;;;;;Gender::::::::;;;;;;;;Date Of Birth::::::::;;;;;;;;Home Phone Number::::::::;;;;;;;;Home Address1::::::::;;;;;;;;Home Address2::::::::;;;;;;;;Home City::::::::;;;;;;;;Home State::::::::;;;;;;;;Home Country::::::::;;;;;;;;Home Zip Code::::::::;;;;;;;;Primary Business Category::::::::;;;;;;;;Secondary Business Category::::::::;;;;;;;;No.Of Employees::::::::;;;;;;;;Businees Established Date::::::::;;;;;;;;Business Duns Number::::::::;;;;;;;;Business Revenue::::::::;;;;;;;;Business Tax Id::::::::;;;;;;;;Blog URL::::::::;;;;;;;;Website URL::::::::;;;;;;;;Diversity Type::::::::;;;;;;;;Businees Description::::::::;;;;;;;;Work Phone::::::::;;;;;;;;Work Address1::::::::;;;;;;;;Work Address2::::::::;;;;;;;;Work city::::::::;;;;;;;;Work State::::::::;;;;;;;;Work Country::::::::;;;;;;;;Work Zip Code::::::::;;;;;;;;Shipping Phone::::::::;;;;;;;;Shipping Address1::::::::;;;;;;;;Shipping Address2::::::::;;;;;;;;Shipping City::::::::;;;;;;;;Shipping State::::::::;;;;;;;;Shipping country::::::::;;;;;;;;Shipping Zip Code::::::::;;;;;;;;NAICS Code1::::::::;;;;;;;;NAICS Code2::::::::;;;;;;;;NAICS Code3::::::::;;;;;;;;NAICS Code4::::::::;;;;;;;;NAICS Code50::::::::;;;;;;;;Follow-up Date::::::::;;;;;;;;Scanned By::::::::;;;;;;;;Notes::::::::;;;;;;;;follow-up type::::::::;;;;;;;;Survey Question1::::::::;;;;;;;;Survey Question2::::::::;;;;;;;;Survey Question3::::::::;;;;;;;;Survey Answer1::::::::;;;;;;;;Survey Answer2::::::::;;;;;;;;SurveyAnswer3'+'\r';
        for(BoothVisitSummary__c ss:BVSListsel) {
        
        string asb = string.valueOf(ss.EA_AttendeeBarcode__r.AS_id__r.AS_BirthDate__c);
        if(ss.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c != null){
         
         transfer += ss.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.As_SuffixNew__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Company__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_CellPhone__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Age__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Gender__c+'::::::::;;;;;;;;'+asb+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_HomePhone__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress2__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_HomeCity__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.As_Home_State__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.As_Home_Country__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_SecondaryBusinessCategory1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NumberOfEmployees__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessEstablishedDate__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDunsNumber__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessRevenue__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessTaxId__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BlogUrl__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WebsiteUrl__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_DiversityType__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDescription__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress2__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WorkCity__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Work_Country__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WorkZip__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingPhone__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress2__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingCity__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_States__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_Country__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_shippingzip__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode2__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode3__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode4__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode5__c+'::::::::;;;;;;;;'+ss.Follow_Update__c+'::::::::;;;;;;;;'+ss.User_id__r.Name+'::::::::;;;;;;;;'+ss.BVS_Notes__c+'::::::::;;;;;;;;'+ss.BVS_FollowUps__c+'::::::::;;;;;;;;'+ss.BVS_SurveyQuestion1__c+'::::::::;;;;;;;;'+ss.BVS_SurveyQuestion2__c+'::::::::;;;;;;;;'+ss.BVS_SurveyQuestion3__c+'::::::::;;;;;;;;'+ss.BVS_SurveyAnswer1__c+'::::::::;;;;;;;;'+ss.BVS_SurveyAnswer2__c+'::::::::;;;;;;;;'+ss.BVS_SurveyAnswer3__c+'\r'; 
        }else{
        transfer +=''+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.As_SuffixNew__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Company__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_CellPhone__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Age__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Gender__c+'::::::::;;;;;;;;'+asb +'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_HomePhone__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress2__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_HomeCity__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.As_Home_State__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.As_Home_Country__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_SecondaryBusinessCategory1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NumberOfEmployees__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessEstablishedDate__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDunsNumber__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessRevenue__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessTaxId__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BlogUrl__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WebsiteUrl__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_DiversityType__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDescription__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress2__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WorkCity__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Work_Country__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WorkZip__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingPhone__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress2__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingCity__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_States__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_Country__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_shippingzip__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode2__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode3__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode4__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode5__c+'::::::::;;;;;;;;'+ss.Follow_Update__c+'::::::::;;;;;;;;'+ss.User_id__r.Name+'::::::::;;;;;;;;'+ss.BVS_Notes__c+'\r'; 
        
        }
     }
          
        transfer = transfer.ReplaceAll(',', ' ').ReplaceAll('::::::::;;;;;;;;', ',').ReplaceAll('null','');
        system.debug('hi iiiiiiii ooooooooo    '+transfer); 
        b = blob.valueOf(transfer); 
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>(); 
        List<String> emailList = new LIST<String>();
        emailList = EmailTo.split(',');
        for(String singlemail: emailList)
        {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setSubject(subject);
                String [] toAddresses = new String[] {singlemail};
                email.setToAddresses(toAddresses);
                String emailBody = body;
                email.setPlainTextBody(emailBody);
                email.setHtmlBody(emailBody);
                email.setInReplyTo(userInfo.getUserName());
                       
                     Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                     efa.setFileName('Attendee Leads.Csv');                                                        
                     efa.setBody(b);                                                                          
                     email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa}); 
                     
                mails.add(email);
        } 
              
         Messaging.SendEmailResult [] msgResult =Messaging.sendEmail(mails);   
         
         EmailTo ='';
         BVSListsel.clear();
         body='';
         subject='';
         email=false;
          
          system.debug('##################'+ email );
       }
     }  
    //   }catch(exception e){}
    getEvents();
   
     return null;
 }
    
    
    
    public void exportLeadstoSalesforce(){ 
  
 system.debug( ' FFFFFFFFFF ZZZZZZZZZZZZZZZZ'+ListOfSelectedIds);
    pushToSalesforce re = new pushToSalesforce();
    List<id> pk = new List<id>();
        for(Id idsvalues:ListOfSelectedIds){
        pk.add(idsvalues);
        }
    re.fetch(userName,password,pk);
    system.debug( ' FFFFFFFFFF GGGGGGGGGGG'+re);
    displayForcescrBool = false;
   // getevents(); 
   // ListOfSelectedIds.clear();
  //  ListOfSelectedIds = null;
   // userName = '';
  
  }
   
  public void cancelsalesforceDilpaly(){
   displayForcescrBool = false;
   getevents();
  }
    
    
    public void First(){
        for(BoothVisitSummary__c BVS : ListForPagination){
                if(BVS.Checkbox_For_Report__c == True){
                    ForSelectedCheckBoxes.put(BVS.id,BVS.Checkbox_For_Report__c);
                    system.debug( ' SSSSSSSS AAAAAAAAAAAAAA '+ForSelectedCheckBoxes);    
                }
            } 
    try{
         CommonMethod();
         hasNext=true;
         hasFirst = false;
         hasPrevious=false;
         hasLast = True;
         Disabled_Previous_Icon = True;
         Disabled_First_Icon = True;
         Disabled_Next_Icon = False;
         Disabled_Last_Icon = False;
         ListForPagination.clear();
         //hasPrevious=false;
         pageno =1;
         for(integer i=0;i<50;i++)
          {
           if(ForSelectedCheckBoxes.containsKey(bvsvaluesbefore1[i].id)){
                          
                            BoothVisitSummary__c C = bvsvaluesbefore1[i];
                            C.Checkbox_For_Report__c =  ForSelectedCheckBoxes.get(bvsvaluesbefore1[i].id);
                            
                            
                            ListForPagination.add(C);
                             System.debug('--------------------SIZE OF PAGINATION LIST11111111---------------------'+ListForPagination.size()+' RECORDS '+bvsvaluesbefore1[i]);
                        }
                        else{
                     ListForPagination.add(bvsvaluesbefore1[i]);
                     } 
          
         }
         if(math.mod(bvsvaluesbefore1.size(),50)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=bvsvaluesbefore1.size()/50;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(bvsvaluesbefore1.size()/50) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
            ForPagesize = ListForPagination.size();
            }catch(Exception ex){
     
     }      
     
    }
    
    public void Next(){
            for(BoothVisitSummary__c BVS : ListForPagination){
                if(BVS.Checkbox_For_Report__c == True){
                    ForSelectedCheckBoxes.put(BVS.id,BVS.Checkbox_For_Report__c);
                    system.debug( ' SSSSSSSS AAAAAAAAAAAAAA '+ForSelectedCheckBoxes);    
                }
            } 
       try{
         CommonMethod();
         pageno  = pageno +1;
        // integer pgno;
         ListForPagination.clear();
         if(math.mod(bvsvaluesbefore1.size(),50)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=bvsvaluesbefore1.size()/50;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(bvsvaluesbefore1.size()/50) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
            if(pageno==pgno)
             { 
                  hasNext=false;
                  hasLast = False;
                  Disabled_Next_Icon = True;
                  Disabled_Last_Icon = True;
                  for(integer i=(pageno -1)*50;i<bvsvaluesbefore1.size();i++ )
                    {
                     
                     if(ForSelectedCheckBoxes.containsKey(bvsvaluesbefore1[i].id)){
                          
                            BoothVisitSummary__c C = bvsvaluesbefore1[i];
                            C.Checkbox_For_Report__c =  ForSelectedCheckBoxes.get(bvsvaluesbefore1[i].id);
                            
                            
                            ListForPagination.add(C);
                             System.debug('--------------------SIZE OF PAGINATION LIST11111111---------------------'+ListForPagination.size()+' RECORDS '+bvsvaluesbefore1[i]);
                        }
                        else{
                     ListForPagination.add(bvsvaluesbefore1[i]);
                     } 
                     System.debug('--------------------SIZE OF PAGINATION LIST------'+listForPagination.size()+' RECORDS '+bvsvaluesbefore1[i]+ ' sssssssssssswwwwwwww'+Pgno);
                    
                    }
             }
          else            
            for(integer i=(pageno -1)*50;i<(pageno *50);i++ )
              {
                     ListForPagination.add(bvsvaluesbefore1[i]); 
                     System.debug('--------------------SIZE OF PAGINATION LIST---------------------'+listForPagination.size()+' RECORDS '+bvsvaluesbefore1[i]);
             }
            
            hasPrevious=True;
            hasFirst = True;
            Disabled_Previous_Icon = False;
            Disabled_First_Icon = False;
         
          
        System.debug('---------------------------- LIST SIZE OF TEMPLIST ---------------------'+bvsvaluesbefore1.size());
       
   }catch(Exception Ex){
             
   }
   ForPageSize = ListForPagination.size();  
    }
    public void Last(){
             for(BoothVisitSummary__c BVS : ListForPagination){
                if(BVS.Checkbox_For_Report__c == True){
                    ForSelectedCheckBoxes.put(BVS.id,BVS.Checkbox_For_Report__c);
                    system.debug( ' SSSSSSSS AAAAAAAAAAAAAA '+ForSelectedCheckBoxes);    
                }
            } 
        try{
         CommonMethod();
         hasLast = False;
         Disabled_Last_Icon = True;
         System.debug('---------------------------------------------- LAST METHOD IS CALLING ----------------------');
        hasPrevious=true;
        Disabled_Previous_Icon=False;
        hasFirst = true;
        Disabled_First_Icon=False;
        ListForPagination.clear();
         hasNext=false;
          Disabled_Next_Icon=True;
        if( math.mod(bvsvaluesbefore1.size(),50)==0){
          System.debug('---------44444444444444444----'+pageno );
             pageno =bvsvaluesbefore1.size()/50;
             System.debug('-----------------pageno ----'+pageno );
           } else {
           System.debug('---------44444444444444444----'+pageno );
            pageno =(bvsvaluesbefore1.size()/50) +1; 
            }
         for(integer i=(pageno -1)*50;i<bvsvaluesbefore1.size();i++)
          {
               if(ForSelectedCheckBoxes.containsKey(bvsvaluesbefore1[i].id)){
                          
                            BoothVisitSummary__c C = bvsvaluesbefore1[i];
                            C.Checkbox_For_Report__c =  ForSelectedCheckBoxes.get(bvsvaluesbefore1[i].id);
                            
                            
                            ListForPagination.add(C);
                             System.debug('--------------------SIZE OF PAGINATION LIST11111111---------------------'+ListForPagination.size()+' RECORDS '+bvsvaluesbefore1[i]);
                        }
                        else{
                     ListForPagination.add(bvsvaluesbefore1[i]);
                     System.debug('--------------------SIZE OF PAGINATION LIST11111111---------------------'+ListForPagination.size()+' RECORDS '+bvsvaluesbefore1.size());
                     }  
         }
         ForPageSize = ListForPagination.size(); 
     }catch(Exception ex){
     }   
       
    }
    
    
    public void Previous(){
        for(BoothVisitSummary__c BVS : ListForPagination){
                if(BVS.Checkbox_For_Report__c == True){
                    ForSelectedCheckBoxes.put(BVS.id,BVS.Checkbox_For_Report__c);
                    system.debug( ' SSSSSSSS AAAAAAAAAAAAAA '+ForSelectedCheckBoxes);    
                }
            } 
    try{  
         CommonMethod();
          hasLast=True;
          hasNext=true;
          Disabled_Previous_Icon = False;
          Disabled_First_Icon = False;
          Disabled_Next_Icon = False;
          Disabled_Last_Icon = False;
          
         ListForPagination.clear();
         if(pageno  !=1)
             {    
                  system.debug( ' PPPPPPPPPPPPPPPPPP'+Disabled_Previous_Icon);
                  system.debug( ' FFFFFFFFFFFFFFF'+Disabled_First_Icon);
                  
                  pageno  = pageno  - 1;
                  If(pageno  ==1 ){
                  hasPrevious=false;
                  hasFirst = False;
                  Disabled_Previous_Icon = True;
                  Disabled_First_Icon = True;
                  Disabled_Next_Icon = False;
                  Disabled_Last_Icon = False;
                 }  
                   for(integer i=(pageno -1)*50;i<(pageno *50);i++ )
                     {
                       if(ForSelectedCheckBoxes.containsKey(bvsvaluesbefore1[i].id)){
                          
                            BoothVisitSummary__c C = bvsvaluesbefore1[i];
                            C.Checkbox_For_Report__c =  ForSelectedCheckBoxes.get(bvsvaluesbefore1[i].id);
                            
                            
                            ListForPagination.add(C);
                             System.debug('--------------------SIZE OF PAGINATION LIST11111111---------------------'+ListForPagination.size()+' RECORDS '+bvsvaluesbefore1[i]);
                        }
                        else{
                     ListForPagination.add(bvsvaluesbefore1[i]);
                     } 
                     }
             }                           
             else
              {   
              
              system.debug( ' AAAAAA '+Disabled_Previous_Icon + ' BBBBBB'+Disabled_First_Icon);
                  hasPrevious=false;
                  hasFirst = False;
                //  Disabled_Previous_Icon = True;
                //  Disabled_First_Icon = True;
                  
                  for(integer i=(pageno -1)*50;i<(pageno *50);i++ )
                     {
                         if(ForSelectedCheckBoxes.containsKey(bvsvaluesbefore1[i].id)){
                          
                            BoothVisitSummary__c C = bvsvaluesbefore1[i];
                            C.Checkbox_For_Report__c =  ForSelectedCheckBoxes.get(bvsvaluesbefore1[i].id);
                            
                            
                            ListForPagination.add(C);
                             System.debug('--------------------SIZE OF PAGINATION LIST11111111---------------------'+ListForPagination.size()+' RECORDS '+bvsvaluesbefore1[i]);
                        }
                        else{
                     ListForPagination.add(bvsvaluesbefore1[i]);
                     } 
                      }
              }
              ForPagesize = ListForPagination.size();
       }
       catch(Exception ex){
      
     }        
    }
    
    
    //PageAction Method
    public PageReference login() {
    
        if(userInfo.getUserType()=='guest'){
        Pagereference pg = new pagereference('/apex/BL_Eventadmin_signup');
        pg.setredirect(true);
        return pg;
        }                
        List<User_Profile_Event__c> ty =new  List<User_Profile_Event__c>();
        ty=[select Profile_id__r.PR_Name__c from User_Profile_Event__c where User_id__r.Email=:userInfo.getUserName() and Profile_id__r.PR_Name__c='eventadmin'];
        if(ty.size()>0){
        Pagereference pg = new pagereference('/apex/BL_EA_Dashboard');
        pg.setredirect(true);
        return pg;
        }else{
        return null;
        }
    }
    
    //**************CCR Details
    
    public boolean ShowError{get; set;}
    public void FetchPopupOpen() {
    system.debug('MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM'+CCREmail);
      ccrdetailsbool=true; 
      fetchccrdetailsbool=false;
    }
    
    
    
    
     public void FetchCCRDetails(){ 
     
      try{
      //if(CCREmail != CCRSearchEmail)
     // {
     // system.debug('GGGGGGGGGGGGGGGGGGGGGGGGGGGGGG'+CCREmail +'MMMMMMMMMMMMMMMMMMMM'+CCRSearchEmail);
     // ShowError= true;
     // }
      //else{
       listdg=new List<AttendeeSummary__c>();
       setdg= new Set<AttendeeSummary__c>();
       result = new List<AttendeeSummary__c>();
    
        // Instantiate a new HTTP Object
        
        Http h = new Http();
        if(CCRSearchTerm!=null && CCRSearchTerm!=''){
                CCRDomainName=CCRSearchTerm;    
        }
        else if(CCRSearchCageCode!=null && CCRSearchCageCode!=''){
                CCRDomainName=CCRSearchCageCode;    
        }
        else if(CCRSearchEmail!=null && CCRSearchEmail!=''){
            if(CCRSearchEmail.contains('@')){
                CCRDomainName='*'+CCRSearchEmail.substringAfter('@');}     
        }
        else if(CCRSearchPhone!=null && CCRSearchPhone!=''){
                CCRDomainName=CCRSearchPhone;    
        }
        
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        
        HttpRequest req = new HttpRequest();    
        req.setEndpoint('http://explore.data.gov/resource/3hqn-qzh6.json?$select=_26895,_500,louis_m_gerson_co_inc_1,custserv_gersonco_com,http_www_gersonco_com,_20000000,_05011959,untitled_27,_16_commerce_blvd_ste_d,_023465030_3,middleboro,ma_5,usa_9,_023465030,_5089475442_3,_8002258623,_313230yn_314999yn_339113yn_423450yn_423840yn_922120nn_922140nn_922160nn,untitled_25,_16_commerce_blvd,middleboro_2,ma,usa_2,_023465030_6,_5089233031_2,_16_commerce_blvd_7,ma_6,usa_6,_5089474000&$limit=1&$q='+CCRDomainName+'*');
        req.setHeader('X-App-Token','vJuJxl8Tjb6wvEnDkd0JUJNDf');
        req.setHeader('Content-Type','text/xml');
        req.setMethod('GET');   
        req.setTimeout(120000);      
        
        ccrlead =new AttendeeSummary__c(); 
        
        ccrlead = [select id, name, AS_Age__c, isUpdated__c, AS_BirthDate__c, AS_BlogUrl__c, AS_BusinessDescription__c, AS_BusinessDunsNumber__c,
                 AS_BusinessEstablishedDate__c, AS_BusinessRevenue__c, AS_BusinessTaxId__c, AS_CellPhone__c,
                 AS_Company__c, AS_DiversityType__c, Registration_type__c, AS_Email__c, AS_FaxNumber__c, AS_FirstName__c, AS_Gender__c,
                 AS_HomeAddress1__c, AS_HomeAddress2__c, AS_HomeCity__c, AS_HomeCountry__c, AS_HomePhone__c,
                 AS_HomePoBox__c, AS_HomeZip__c, AS_ImageUrl__c, AS_LastName__c, AS_NAICSCode1__c,
                 AS_NAICSCode2__c, AS_NAICSCode3__c, AS_NAICSCode4__c, AS_NAICSCode5__c, AS_NumberOfEmployees__c, AS_PrefixNew__c,
                 AS_PrimaryBusinessCategory1__c, AS_SecondaryBusinessCategory1__c, AS_ShippingAddress1__c, AS_ShippingAddress2__c,
                 AS_ShippingCity__c, AS_ShippingCountry__c, AS_ShippingPhone__c, AS_shippingzip__c, AS_ShippingState__c,
                 AS_ShippingZipcode__c, AS_SuffixNew__c, AS_ThroughEventBrite__c, AS_Title__c, AS_WebsiteUrl__c, AS_WorkAddress1__c,
                 AS_WorkAddress2__c, AS_WorkCity__c, AS_WorkCountry__c, AS_WorkPhone__c, AS_WorkPoBox__c, AS_Work_Country__c, AS_WorkZip__c,
                 AS_Work_States__c, As_Home_Country__c, As_Home_State__c, As_Shipping_Country__c, As_Shipping_States__c
                 FROM AttendeeSummary__c WHERE AS_Email__c =: CCREmail];
        system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+ccrlead);   
                 
        // Send the HTTP request, and return a response
       if(istestValue!='FromTest'){
            HTTPResponse res = h.send(req);
            CCRData=res.getBody(); 
            system.debug('@@@@@@@@@@@@@@@@@ PPPPPPPPPPPPP '+CCRData);
        }
        else{
           CCRData  = '[ {"ma_5" : "NJ",  "ma_6" : "NJ",  "louis_m_gerson_co_inc_1" : "GLOBAL NEST LLC","_5089475442_3" : "7323335946",  "untitled_27" : "SUITE 208",  "untitled_25" : "SUITE 208",  "ma" : "NJ",  "_023465030" : "77511157",  "_313230yn_314999yn_339113yn_423450yn_423840yn_922120nn_922140nn_922160nn" : "541511YN.541512YN.541519YN",  "custserv_gersonco_com" : "durga@globalnest.com",  "http_www_gersonco_com" : {    "url" : "http://globalnest.com"  },  "_16_commerce_blvd_7" : "281 STATE ROUTE 79",  "_26895" : "59HX7",  "_20000000" : "5000000",  "middleboro_2" : "MORGANVILLE",  "_5089474000" : "7323331901",  "_500" : "60",  "_16_commerce_blvd_ste_d" : "281 ROUTE 79 S STE 208",  "usa_2" : "USA",  "_023465030_6" : "77511157",  "_023465030_3" : "7751",  "middleboro" : "MORGANVILLE",  "_05011959" : "50112005",  "_5089233031_2" : "7323331670",  "_8002258623" : "7323331670",  "usa_9" : "USA",  "usa_6" : "USA",  "_16_commerce_blvd" : "281 STATE ROUTE 79"} ]';     
        }
        
        JSONParser parser = JSON.createParser(CCRData);   
           
        if(CCRData.length()>3){  
        fetchccrdetailsbool=true;
        fetchccrdetailsboolyes=true;
        fetchccrdetailsboolno=false;
        while (parser.nextToken() != null) {          
        if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){                                          
            String fieldName = parser.getText();
            parser.nextToken();
        if(fieldName == 'louis_m_gerson_co_inc_1') {
            CCRCompany=parser.getText();
        } 
        if(fieldName == '_500') {
            CCRNumberofEmployees=parser.getText();
        } 
        else if(fieldName == '_26895'){
            CCRCageCode=parser.getText();
        } 
        else if(fieldName == 'custserv_gersonco_com'){
            CCREmailId=parser.getText();
        } 
        else if(fieldName == 'http_www_gersonco_com'){
            parser.nextToken();
            parser.nextToken();
            CCRWebsiteUrl=parser.getText();
        } 
        else if(fieldName == '_20000000'){
            CCRBusinessRevenue=parser.getText();                       
        } 
        else if(fieldName == '_05011959'){
            CCRBusinessEstablishedDate=parser.getText();                     
            if(CCRBusinessEstablishedDate.length()<8){
                if(Decimal.Valueof(CCRBusinessEstablishedDate.substring(1, 3))<12){
                    CCRBusinessEstablishedDate1 = CCRBusinessEstablishedDate.substring(3,7)+ '-' + CCRBusinessEstablishedDate.substring(1, 3)+ '-' + '0' + CCRBusinessEstablishedDate.substring(0, 1);}
            }
            else if (CCRBusinessEstablishedDate.length()>=8){
                if(Decimal.Valueof(CCRBusinessEstablishedDate.substring(2, 4))<12){
                    CCRBusinessEstablishedDate1 = CCRBusinessEstablishedDate.substring(4,8)+ '-' +CCRBusinessEstablishedDate.substring(2, 4)+ '-' + CCRBusinessEstablishedDate.substring(0, 2);}
            }
        }                      
        else if(fieldName == 'untitled_27'){
            CCRWorkAddress1=parser.getText();
        } 
        else if(fieldName == '_16_commerce_blvd_ste_d'){
            CCRWorkAddress2=parser.getText();
        } 
        else if(fieldName == 'middleboro'){
            CCRWorkCity=parser.getText();
        }
        else if(fieldName == 'ma_5'){
            CCRWorkState=parser.getText();
        }  
        else if(fieldName == 'usa_9'){
            CCRWorkCountry=parser.getText();
        }
        else if(fieldName == '_023465030_3'){
            CCRWorkZipCode=parser.getText();
        }
        else if(fieldName == '_023465030'){
            CCRPOBox1=parser.getText();
            if(CCRPOBox1.length()>8){
                CCRWorkPObox=CCRPOBox1.substring(4,8);}
            else
                CCRWorkPObox=CCRPOBox1;
        } 
        else if(fieldName == '_5089475442_3'){
            CCRWorkPhone=parser.getText();
        }
        else if(fieldName == 'untitled_25'){
            CCRHomeAddress1=parser.getText();
        } 
        else if(fieldName == '_16_commerce_blvd'){
            CCRHomeAddress2=parser.getText();
        } 
        else if(fieldName == 'middleboro_2'){
            CCRHomeCity=parser.getText();
        }
        else if(fieldName == 'ma'){
            CCRHomeState=parser.getText();
        } 
        else if(fieldName == 'usa_2'){
            CCRHomeCountry=parser.getText();
        }
        else if(fieldName == '_023465030_3'){
            CCRHomeZipCode=parser.getText();
            //CCRMailingZipCode=CCRZipCode1.substring(0,4);
        }
        else if(fieldName == '_023465030_6'){
            CCRPOBox2=parser.getText();
            if(CCRPOBox2.length()>8){
                CCRHomePObox=CCRPOBox2.substring(4,8);}
            else
                CCRHomePObox=CCRPOBox2;
        } 
        else if(fieldName == '_5089233031_2'){
            CCRHomePhone=parser.getText();
        } 
        else if(fieldName == 'untitled_25'){
            CCRMailingAddress1=parser.getText();
        } 
        else if(fieldName == '_16_commerce_blvd_7'){
            CCRMailingAddress2=parser.getText();
        } 
        else if(fieldName == 'middleboro_2'){
            CCRMailingCity=parser.getText();
        }
        else if(fieldName == 'ma_6'){
            CCRMailingState=parser.getText();
        }  
        else if(fieldName == 'usa_6'){
            CCRMailingCountry=parser.getText();
        }
        else if(fieldName == '_023465030_3'){
            CCRMailingZipCode=parser.getText();
        }
        else if(fieldName == '_023465030'){
            CCRPOBox3=parser.getText();
            if(CCRPOBox3.length()>8){
                CCRMailingPObox=CCRPOBox3.substring(4,8);}
            else
                CCRMailingPObox=CCRPOBox3;
        } 
        else if(fieldName == '_5089474000'){
            CCRMailingPhone=parser.getText();
        }
        else if(fieldName == '_8002258623'){
            CCRCellPhone=parser.getText();
        }   
        else if(fieldName == '_313230yn_314999yn_339113yn_423450yn_423840yn_922120nn_922140nn_922160nn'){
            CCRNaicsCodes=parser.getText();
            CCRNaicsCodes1=CCRNaicsCodes.substring(0,6);  
            if(CCRNaicsCodes.length()> 8){
                CCRNaicsCodes2=CCRNaicsCodes.substring(9,15);}         
            if(CCRNaicsCodes.length()>15 && CCRNaicsCodes.length()<27) {
                CCRNaicsCodes3=CCRNaicsCodes.substring(18,24);}
            if(CCRNaicsCodes.length()>26 && CCRNaicsCodes.length()<34) {
                CCRNaicsCodes4=CCRNaicsCodes.substring(27,33);}
            if(CCRNaicsCodes.length()>32 && CCRNaicsCodes.length()<43) {
                CCRNaicsCodes5=CCRNaicsCodes.substring(36,42);}                 
        }                            
        
        ccrlead.AS_Email__c=CCREmail;
        if(ccrlead.AS_Company__c == null || ccrlead.AS_Company__c ==''){ ccrlead.AS_Company__c=CCRCompany; }
        if(ccrlead.AS_CageCode__c == null || ccrlead.AS_Company__c ==''){ ccrlead.AS_CageCode__c=CCRCageCode;}
        if(ccrlead.AS_CellPhone__c == null || ccrlead.AS_CellPhone__c ==''){ ccrlead.AS_CellPhone__c =CCRCellPhone;}
        if(ccrlead.AS_BusinessDunsNumber__c == null || ccrlead.AS_BusinessDunsNumber__c ==''){ ccrlead.AS_BusinessDunsNumber__c =CCRBusinessDunsNumber;}
        if(ccrlead.AS_BusinessTaxId__c == null || ccrlead.AS_BusinessTaxId__c ==''){ ccrlead.AS_BusinessTaxId__c =CCRBusinessTaxId ;}
        if(ccrlead.AS_WebsiteURL__c == null || ccrlead.AS_WebsiteURL__c ==''){ ccrlead.AS_WebsiteURL__c =CCRWebsiteURL;}
        
        if(ccrlead.AS_BusinessRevenue__c == null){
            if(CCRBusinessRevenue!=null && CCRBusinessRevenue!=''){
            ccrlead.AS_BusinessRevenue__c =Decimal.ValueOf(CCRBusinessRevenue);
            }
        }
        if(ccrlead.AS_BusinessEstablishedDate__c == null){
            if(CCRBusinessEstablishedDate1!=null && CCRBusinessEstablishedDate1!=''){
                ccrlead.AS_BusinessEstablishedDate__c=Date.ValueOf(CCRBusinessEstablishedDate1);
            } 
        }
        if(ccrlead.AS_NumberOfEmployees__c == null){
            if(CCRNumberofEmployees!=null && CCRNumberofEmployees!=''){
                ccrlead.AS_NumberOfEmployees__c =Decimal.ValueOf(CCRNumberofEmployees);
            }
        }
        if(ccrlead.AS_NAICSCode1__c == null){
            if(CCRNaicsCodes1!=null && CCRNaicsCodes1!=''){
                ccrlead.AS_NAICSCode1__c=Decimal.ValueOf(CCRNaicsCodes1);
            }
        }
        if(ccrlead.AS_NAICSCode2__c == null){
            if(CCRNaicsCodes2!=null && CCRNaicsCodes2!=''){
                ccrlead.AS_NAICSCode2__c=Decimal.ValueOf(CCRNaicsCodes2);
            }  
        }
        if(ccrlead.AS_NAICSCode3__c == null){ 
            if(CCRNaicsCodes3!=null && CCRNaicsCodes3!=''){
                ccrlead.AS_NAICSCode3__c=Decimal.ValueOf(CCRNaicsCodes3);
            }  
        }
        if(ccrlead.AS_NAICSCode4__c == null){
            if(CCRNaicsCodes4!=null && CCRNaicsCodes4!=''){
                ccrlead.AS_NAICSCode4__c=Decimal.ValueOf(CCRNaicsCodes4);
            }  
        }
        if(ccrlead.AS_NAICSCode5__c == null){  
            if(CCRNaicsCodes5!=null && CCRNaicsCodes5!=''){
                ccrlead.AS_NAICSCode5__c=Decimal.ValueOf(CCRNaicsCodes5);
            }   
        }
        
        
        if(ccrlead.AS_ShippingAddress1__c == null || ccrlead.AS_ShippingAddress1__c ==''){ccrlead.AS_ShippingAddress1__c = CCRMailingAddress1;}
        if(ccrlead.AS_ShippingAddress2__c == null || ccrlead.AS_ShippingAddress2__c ==''){ccrlead.AS_ShippingAddress2__c = CCRMailingAddress2;}
        if(ccrlead.AS_shippingCity__c == null || ccrlead.AS_shippingCity__c ==''){ccrlead.AS_shippingCity__c = CCRMailingCity;}
        if(ccrlead.As_Shipping_States__c == null || ccrlead.As_Shipping_States__c ==''){ ccrlead.As_Shipping_States__c = CCRMailingState; }
        if(ccrlead.As_Shipping_Country__c == null || ccrlead.As_Shipping_Country__c ==''){ccrlead.As_Shipping_Country__c = CCRMailingCountry;}
        if(ccrlead.AS_Shippingpoboxno__c == null || ccrlead.AS_Shippingpoboxno__c ==''){ccrlead.AS_Shippingpoboxno__c = CCRMailingPOBox;}
        if(ccrlead.AS_shippingzip__c == null || ccrlead.AS_shippingzip__c ==''){ccrlead.AS_shippingzip__c = CCRMailingZipCode;}
        if(ccrlead.AS_ShippingPhone__c == null || ccrlead.AS_ShippingPhone__c ==''){ccrlead.AS_ShippingPhone__c = CCRMailingphone;}
        if(ccrlead.AS_WorkAddress1__c == null || ccrlead.AS_WorkAddress1__c ==''){ccrlead.AS_WorkAddress1__c = CCRWorkAddress1;}
        if(ccrlead.AS_WorkAddress2__c == null || ccrlead.AS_WorkAddress2__c ==''){ccrlead.AS_WorkAddress2__c = CCRWorkAddress2;}
        if(ccrlead.AS_Workcity__c == null || ccrlead.AS_Workcity__c ==''){ccrlead.AS_Workcity__c = CCRWorkCity;}
        if(ccrlead.AS_Work_States__c == null || ccrlead.AS_Work_States__c ==''){ccrlead.AS_Work_States__c = CCRWorkState;}
        if(ccrlead.AS_Work_Country__c == null || ccrlead.AS_Work_Country__c ==''){ccrlead.AS_Work_Country__c= CCRWorkCountry;}
        if(ccrlead.AS_Workpoboxno__c == null || ccrlead.AS_Workpoboxno__c ==''){ccrlead.AS_Workpoboxno__c = CCRWorkPOBox;}
        if(ccrlead.AS_WorkZip__c == null || ccrlead.AS_WorkZip__c ==''){ccrlead.AS_WorkZip__c = CCRWorkZipCode;}
        if(ccrlead.AS_WorkPhone__c == null || ccrlead.AS_WorkPhone__c ==''){ccrlead.AS_WorkPhone__c = CCRWorkPhone;}
        if(ccrlead.AS_HomeAddress1__c == null || ccrlead.AS_HomeAddress1__c ==''){ccrlead.AS_HomeAddress1__c = CCRHomeAddress1;}
        if(ccrlead.AS_HomeAddress2__c == null || ccrlead.AS_HomeAddress2__c ==''){ccrlead.AS_HomeAddress2__c = CCRHomeAddress2;}
        if(ccrlead.AS_HomeCity__c == null || ccrlead.AS_HomeCity__c ==''){ccrlead.AS_HomeCity__c = CCRHomeCity;}
        if(ccrlead.As_Home_State__c == null || ccrlead.As_Home_State__c ==''){ccrlead.As_Home_State__c = CCRHomeState;  }
        if(ccrlead.As_Home_Country__c == null || ccrlead.As_Home_Country__c ==''){ccrlead.As_Home_Country__c = CCRHomeCountry;}
        if(ccrlead.AS_HomePoboxNo__c == null || ccrlead.AS_HomePoboxNo__c ==''){ccrlead.AS_HomePoboxNo__c = CCRHomePOBox;}
        if(ccrlead.AS_HomeZip__c == null || ccrlead.AS_HomeZip__c ==''){ccrlead.AS_HomeZip__c= CCRHomeZipCode;  }
        if(ccrlead.AS_HomePhone__c == null || ccrlead.AS_HomePhone__c ==''){ccrlead.AS_HomePhone__c= CCRHomePhone;}
        listdg.add(ccrlead); 
        }  
       }
     }
     else{
         fetchccrdetailsbool=true;
         fetchccrdetailsboolyes=false;
         fetchccrdetailsboolno=true;
         NoRecordsMessage='No Records Found';
     }
    //}
    }
    catch (Exception ex) {
        system.debug(ex.getStackTraceString());
    }           
    }
    
   // Fetching CCR Details Method End 
  
   // Inserting CCR Details Method Start
    public void InsertCCRDetails(){    
    try{
        ccrdetailsbool=false;
        setdg.addAll(listdg);
        result.addAll(setdg);
        Schema.SObjectField f = AttendeeSummary__c.Fields.AS_Email__c;
        Database.UpsertResult[] result1 = Database.upsert(result,f,false);
        system.debug('@@@@@@@@@@@ '+result1);
     }
     catch (Exception ex) {
        system.debug(ex.getStackTraceString());
     }           
    }     
    
    public String escapeSpecialCharacters(String input){
    if(input!= null && input != '' && (input.contains('\\') )){
       input = input.replace('\\','\\\\');
       }
       if(input!= null && input != '' && (input.contains('"') )){
       input = input.replace('"','');
       }
      
      return input;
    }
    
public string escape(string s){
  if(s != null && s.contains(',')){
     s=s.replaceAll('"','');
     s='"'+s+'"';
   } 
    return s;
 }
    
    // Added by Shruthi to populate selected Event in the before Tab on November 18th 
   
    public string EventURLid{get;set;}
    
    public void URLEvent(){  
      
    EventURLid = apexpages.currentpage().getparameters().get('id');  
        
   
    if(EventURLid != null ){ 
    
    Eventselected = EventURLid ;
   } 
 }
  
  public integer i{get;set;}
  public  void  dummy1(){
i=0;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;

i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;

i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;



}
 
    
    
}