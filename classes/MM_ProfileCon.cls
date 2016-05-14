public without sharing class MM_ProfileCon {
    
    public MAP<id,Event_Attendee_Mapping__c> mapIdandObject{get;set;}
    public LIST<User_Profile_Event__c> upe{get; set;}
    public LIST<User_Profile_Event__c> ueserProfile{get; set;}
    public List<inn> listinn{get;set;}
    public Custom_Widget__c cyoutubevideo {get ; set ;}
    public List<SelectOption> optionsevediversity {get;set;}
    public List<SelectOption> optionsevediversity2 {get;set;}
    public List<string> optionsAttdiversity {get;set;}
    public List<Event_Attendee_Mapping__c> eventslist{get;set;}
    public List<string> optionsattdiversity2 {get;set;}
   public string nodiversity{get;set;}
   public List<Attachment> attachments {get ; set ;}
   public Boolean NaicsBoolean{get;set;}
     public LIST<LIST<Commodities__c>> listOfcommodities {get; set;}
    public list<Custom_Widget__c> cvideos {get ; set ;}
    public boolean displayAttendee{get;set;}
    public boolean displayBoothAdmin{get;set;}
    public boolean displayEventAdmin{get;set;}
    public list<Attachment> attchments {get; set;}
    public String NAICS1Mod{get; set;}
    public String NAICS2Mod{get; set;}
    public String NAICS3Mod{get; set;}
    public String NAICS4Mod{get; set;}
    public String NAICS5Mod{get; set;}
    public String SelectValAs{get;set;}
    public List<selectOption> options{get;set;}
    
    public transient Blob attendeeImage{get; set;}
    public String myimageName{get; set;}
    public Boolean imageerror{get; set;}
    
    public transient  Blob ExhibitorImage{get; set;}
    public String exhibitorImageName{get; set;}
    public Boolean exebitorimageerror{get; set;}
    
    public AttendeeSummary__c atta {get;set;}
    //For adding video
        public Widget__c youtubevideo {get ; set;}
        
      
 //Diversity Type
 
   Public List<String> Selvalue {get;set;}
    Public Boolean Select0{get;set;}
    Public Boolean Select1{get;set;}
    Public Boolean Select2{get;set;}
    Public Boolean Select3{get;set;}
    Public Boolean Select4{get;set;}
    Public Boolean Select5{get;set;}
    Public Boolean Select6{get;set;}
    Public Boolean Select7{get;set;}
    Public Boolean Select8{get;set;}
    Public Boolean Select9{get;set;}
    Public Boolean Select10{get;set;} 
    Public Boolean Select11{get;set;}
    Public Boolean Select12{get;set;}
    Public Boolean Select13{get;set;}
    Public Boolean Select14{get;set;}   
    
    public String selectedNAICS1 { get; set; }
    public string selectedNAICS2{ get; set; }
    public string selecteddelnaic{ get; set; }
    public NAICS_Code__c selectednaicscodeslist  { get; set; }
    public List<String> selectednacslist{ get; set; }
    public set<string> naicsset{ get; set; }
    public List<String> selecteddelnaicsplit{ get; set; }
    public NAICS_Code__c naicsdellist { get; set; }
    public Boolean naicsalertbool{get;set;}
    public Boolean delbool{get;set;} 
    public List<NAICS_Code__c> naicscodeslist{get;set;}
        
    Public string selectedvaluesfordiversity{get;set;}
   
    public LIST<LIST<NAICS_Code__c>> listOfnaicscodes{get; set;}
    public string naicsselctdids{get;set;}
    public list<string> naicscods{get;set;} 
    public List<Commodities__c> commoditieslist {get ; set ;}
    public String checkNAICSforAttendeeEdit{get; set;}
    public string SelectEvent  {get ; set ; }
    public string  checkCommforAttendeeEdit {get ; set ;}
    Public transient Attachment myfile;
    public Event__c event {get ; set ;}
    public  list<selectOption> georegion {get ; set ;}
    public List<string> selectedregions {get ; set ;}
    public List<Profile_Settings__c> mbesettings {get ; set ;}
    public Profile_Settings__c pset{get;set;}
     public  MBE_Profile__c mbeproSingle{get;set;}  
      public String vppagename{get;set;}    
       public List<string> DiversityList{get;set;}
    public string DiversityExisted {get;set;}
      
    //--------------------CONSTRUCTOR----
    public MM_ProfileCon(){
                        
      try{
     Cookie viewprofile=ApexPages.currentPage().getCookies().get('viewprofile');
     vppagename=viewprofile.getValue();
     viewprofile= new Cookie('viewprofile',null,null,-1,false);
     ApexPages.currentPage().setCookies(new Cookie[]{viewprofile});  
     
     }catch(Exception e){}
     DiversityList = new List<string>();
                              pset = new  Profile_Settings__c();
                                SelectEvent  = '' ;
                                Cookie k = ApexPages.currentPage().getCookies().get('counter');
                                system.debug('sssssssssssssssss'+k);
                                SelectEvent = k.getValue();
                                event = [SELECT id,Is_Webank_event__c,EV_Title__c from Event__c WHERE id =:SelectEvent];
                                Selvalue =new LIST<String> ();
                                naicscods= new list<string>();
                                atta = new AttendeeSummary__c();
                                georegion = new list<selectOption> ();
                                   georegion.add(new selectoption('Local','Local'));
                                   georegion.add(new selectoption('National','National'));
                                   georegion.add(new selectoption('Global','Global'));
                                   georegion.add(new selectoption('Regional NE','Regional NE'));
                                   georegion.add(new selectoption('Regional SW','Regional SW'));
                                   georegion.add(new selectoption('Regional NW','Regional NW'));
                                   georegion.add(new selectoption('Regional SE','Regional SE'));
                                   selectedregions = new List<string>();
                                DelId = '';
                                naicsselctdids = '';
                                youtubevideo = new Widget__c();
                                       displayAttendee =false;
                                       displayEventAdmin =false;  
                                       displayBoothAdmin =false;
                                          
                                         List<User_Profile_Event__c> upe = new List<User_Profile_Event__c>();
                                         upe =[select id,Profile_id__c,Profile_id__r.PR_Name__c, MAtchMakingProfile__c from User_Profile_Event__c where User_id__c=:userInfo.getUserId() and EV_id__r.id =: SelectEvent limit 1];
                                        //system.debug('============== ' + upe[0].Profile_id__r.PR_Name__c);
                                        if(upe.size()>0){

                                                 if(upe[0].Profile_id__r.PR_Name__c =='EventAdmin'){
                                                         displayEventAdmin =true;
                                                 }else if(upe[0].MAtchMakingProfile__c =='Corporate' ){
                                                          displayBoothAdmin =true;
                                                 }else if(upe[0].MAtchMakingProfile__c =='MBE' ){
                                                          displayAttendee=true;
                                                 }
                                        } 
                                                system.debug('============== ' + displayEventAdmin );
                                //    MAtchMakingProfile__c
                                        listOfnaicscodes= new LIST<LIST<NAICS_Code__c>>();
                                          naicscodeslist = new List<NAICS_Code__c>();
                                        
                                       for(NAICS_Code__c n : [select id,name,Description__c from NAICS_Code__c ]){
                                          
                                                  naicscodeslist.add(n);
                                                  
                                                 if(naicscodeslist.size() == 999){
                                                                 listOfnaicscodes.add(naicscodeslist);
                                                                 naicscodeslist= new LIST<NAICS_Code__c>();
                                                         }
                         
                                          }
                                         
                                          if(naicscodeslist.size() != 0){
                                                  listOfnaicscodes.add(naicscodeslist);
                                         } 
                                         
                                   system.debug('111111111111111111 ' + listOfnaicscodes);  listOfcommodities= new LIST<LIST<Commodities__c>>();
                                                        commoditieslist = new List<Commodities__c>();
                                        
                                          for(Commodities__c n : [select id,name,Description__c from Commodities__c ]){
                                          
                                                  commoditieslist.add(n);
                                                  
                                                 if(commoditieslist.size() == 999){
                                                                 listOfcommodities.add(commoditieslist);
                                                                 commoditieslist = new LIST<Commodities__c>();
                                                         }
                         
                                          }
                                          
                                          if(commoditieslist.size() != 0){
                                                  listOfcommodities.add(commoditieslist);
                                         } 
                                        
                                                                                
                                  try{
                                        attendeedetails();
                                        system.debug('===========@@@@@@' + atta.Attachments);
                                          checkNAICSforAttendeeEdit = '!@##$$$$###@';
                                          checkCommforAttendeeEdit = '!@##$$$$###@'; 
                                if(profile1){  
                                  system.debug('shruthi shruhi 111' + atta.AS_NAICSCode_1__c) ;  
                                  system.debug('shruthi shruhi 222 ' + atta.AS_NAICSCode_2__c) ;  
                                  system.debug('shruthi shruhi33 ' + atta.AS_NAICSCode_3__c) ;  
                                  system.debug('shruthi shruhi 444' + atta.AS_NAICSCode_4__c) ;  
                                  system.debug('shruthi shruhi 555' + atta.AS_NAICSCode_5__c) ;  
                          if(atta.AS_NAICSCode_1__c!=null ){
                                 checkNAICSforAttendeeEdit += atta.AS_NAICSCode_1__c;
                                 }if(atta.AS_NAICSCode_2__c!=null ){
                                 checkNAICSforAttendeeEdit += atta.AS_NAICSCode_2__c;
                                 }if(atta.AS_NAICSCode_3__c!=null ){
                                 checkNAICSforAttendeeEdit += atta.AS_NAICSCode_3__c;
                                 }if(atta.AS_NAICSCode_4__c!=null ){
                                  checkNAICSforAttendeeEdit += atta.AS_NAICSCode_4__c;
                                 }if(atta.AS_NAICSCode_5__c!=null ){
                                  checkNAICSforAttendeeEdit += atta.AS_NAICSCode_5__c;
                                 }if(atta.AS_NAICSCode6__c!=null ){
                                  checkNAICSforAttendeeEdit += atta.AS_NAICSCode6__c;
                                 }if(atta.AS_NAICSCode7__c!=null ){
                                  checkNAICSforAttendeeEdit += atta.AS_NAICSCode7__c;
                                 }if(atta.AS_NAICSCode8__c!=null ){
                                  checkNAICSforAttendeeEdit += atta.AS_NAICSCode8__c;
                                 }if(atta.AS_NAICSCode9__c!=null ){
                                  checkNAICSforAttendeeEdit += atta.AS_NAICSCode9__c;
                                 }
                                 system.debug(':::::::::::::::Raichal::::::::::::'+checkNAICSforAttendeeEdit);
                                 if(atta.Commodity_1__c!=null ){
                                 checkCommforAttendeeEdit += ','+atta.Commodity_1__c;
                                 }if(atta.Commodity_2__c!=null ){
                                 checkCommforAttendeeEdit += ','+atta.Commodity_2__c;
                                 }if(atta.Commodity_3__c!=null ){
                                 checkCommforAttendeeEdit += ','+atta.Commodity_3__c;
                                 }if(atta.Commodity_4__c!=null ){
                                  checkCommforAttendeeEdit += ','+atta.Commodity_4__c;
                                 }if(atta.Commodity_5__c!=null ){
                                  checkCommforAttendeeEdit += ','+atta.Commodity_5__c;
                                 }if(atta.Commodity_6__c!=null ){
                                 checkCommforAttendeeEdit += ','+atta.Commodity_6__c;
                                 }if(atta.Commodity_7__c!=null ){
                                 checkCommforAttendeeEdit += ','+atta.Commodity_7__c;
                                 }if(atta.Commodity_8__c!=null ){
                                  checkCommforAttendeeEdit += ','+atta.Commodity_8__c;
                                 }if(atta.Commodity_9__c!=null ){
                                  checkCommforAttendeeEdit += ','+atta.Commodity_9__c;
                                 }
                                 system.debug(':::::::::::::::Raichal::::::::::::'+checkCommforAttendeeEdit);
                          }else{
                                if(mbepro[0].AS_NAICSCode_1__c!=null ){
                                 checkNAICSforAttendeeEdit += mbepro[0].AS_NAICSCode_1__c;
                                 }if(mbepro[0].AS_NAICSCode_2__c!=null ){
                                 checkNAICSforAttendeeEdit += mbepro[0].AS_NAICSCode_2__c;
                                 }if(mbepro[0].AS_NAICSCode_3__c!=null ){
                                 checkNAICSforAttendeeEdit += mbepro[0].AS_NAICSCode_3__c;
                                 }if(mbepro[0].AS_NAICSCode_4__c!=null ){
                                  checkNAICSforAttendeeEdit += mbepro[0].AS_NAICSCode_4__c;
                                 }if(mbepro[0].AS_NAICSCode_5__c!=null ){
                                  checkNAICSforAttendeeEdit += mbepro[0].AS_NAICSCode_5__c;
                                 }if(mbepro[0].AS_NAICSCode6__c!=null ){
                                  checkNAICSforAttendeeEdit += mbepro[0].AS_NAICSCode6__c;
                                 }if(mbepro[0].AS_NAICSCode7__c!=null ){
                                  checkNAICSforAttendeeEdit += mbepro[0].AS_NAICSCode7__c;
                                 }if(mbepro[0].AS_NAICSCode8__c!=null ){
                                  checkNAICSforAttendeeEdit += mbepro[0].AS_NAICSCode8__c;
                                 }if(mbepro[0].AS_NAICSCode9__c!=null ){
                                  checkNAICSforAttendeeEdit += mbepro[0].AS_NAICSCode9__c;
                                 }
                                                        
                                  if(mbepro[0].Commodity_1__c!=null ){
                                 checkCommforAttendeeEdit += ','+mbepro[0].Commodity_1__c;
                                 }if(mbepro[0].Commodity_2__c!=null ){
                                 checkCommforAttendeeEdit += ','+mbepro[0].Commodity_2__c;
                                 }if(mbepro[0].Commodity_3__c!=null ){
                                 checkCommforAttendeeEdit += ','+mbepro[0].Commodity_3__c;
                                 }if(mbepro[0].Commodity_4__c!=null ){
                                  checkCommforAttendeeEdit += ','+mbepro[0].Commodity_4__c;
                                 }if(mbepro[0].Commodity_5__c!=null ){
                                  checkCommforAttendeeEdit += ','+mbepro[0].Commodity_5__c;
                                 }if(mbepro[0].Commodity_6__c!=null ){
                                 checkCommforAttendeeEdit += ','+mbepro[0].Commodity_6__c;
                                 }if(mbepro[0].Commodity_7__c!=null ){
                                 checkCommforAttendeeEdit += ','+mbepro[0].Commodity_7__c;
                                 }if(mbepro[0].Commodity_8__c!=null ){
                                  checkCommforAttendeeEdit += ','+mbepro[0].Commodity_8__c;
                                 }if(mbepro[0].Commodity_9__c!=null ){
                                  checkCommforAttendeeEdit += ','+mbepro[0].Commodity_9__c;
                                 }
                          }               
                                  system.debug('shruthi sankeeth  ' + checkCommforAttendeeEdit);
                                                   
                                                                //------------------------------Diversity-------
                                                                 System.debug('XXXXXXXXXXXXXXXX '+atta.Id);                                  
                                                                eventslist = new List<Event_Attendee_Mapping__c>();
                                                                eventslist  =[select AS_id__r.Id,EV_id__c,EV_id__r.EV_Title__c,EV_id__r.EventDiversityValues__c,DiversityType__c from Event_Attendee_Mapping__c where AS_id__c=:atta.Id and EV_Id__c =:SelectEvent and  AS_id__c != null];
                                                               
                                                               //and (EV_id__r.Status__c='Event in Progress' Or EV_id__r.Status__c='Event Registration Open')
                                                                listinn = new List<inn>();
                                                                mapIdandObject = new MAP<Id,Event_Attendee_Mapping__c>();
                                                                if(eventslist.size()==0){
                                                                 nodiversity ='No Diversities found';
                                                                 
                                                                 }
                                                          SET<string> removediverdups = new SET<string>();      
                                                            for(Event_Attendee_Mapping__c at :eventslist){
                                                            
                                                                mapIdandObject.put(at.AS_id__r.Id,at);
                                                                
                                                                /* System.debug('XXXXXXXXXXXXXXXX '+at.id);
                                                                optionsAttdiversity = new List<string>();
                                                                optionsattdiversity2 = new List<string>();
                                                                optionsevediversity = new List<SelectOption>();
                                                                optionsevediversity2 = new List<SelectOption>();
                                                             integer i=0;*/
                                                                 for(string s:at.EV_id__r.EventDiversityValues__c.split(';')){
                                                                       if(!removediverdups.contains(s)){
                                                                           DiversityList.add(s);
                                                                           removediverdups.add(s);
                                                                        }
                                                                  }
                                                              
                                                            if(at.DiversityType__c != null){
                                                                     for(string ps : at.DiversityType__c.split(';')){
                                                                        DiversityExisted+=ps;
                                                                      }
                                                                }
                                                                //  listinn.add(new inn(at.EV_id__r.EV_Title__c,optionsAttdiversity ,optionsevediversity2,optionsevediversity,at.id,optionsattdiversity2 ));
                                                                 
                                                          }
                                                   System.debug('ZZZZZZZZZZZZZZZZZZZZZ   '+DiversityExisted +'YYYYYYY  '+DiversityList.size());                     
                           if(atta.AS_DiversityType__c != NULL){
                           if(atta.AS_DiversityType__c.containsIgnoreCase('Minority Owned Business Enterprise'))
                           Select0 = True;
                           if(atta.AS_DiversityType__c.containsIgnoreCase('Disadvantaged Business Enterprise'))
                           select1 = True;
                           if(atta.AS_DiversityType__c.containsIgnoreCase('Service Disabled Veteran Business Enterprise'))
                           Select2 = True;
                           if(atta.AS_DiversityType__c.containsIgnoreCase('Small Business Enterprise'))
                           select3 = True;
                           if(atta.AS_DiversityType__c.containsIgnoreCase('Ability One'))
                           Select4 = True;
                           if(atta.AS_DiversityType__c.containsIgnoreCase('Woman Owned Business Enterprise'))
                                Select5 = True;
                           if(atta.AS_DiversityType__c.containsIgnoreCase('SBA 8(A) Program'))
                           Select6 = True;
                           if(atta.AS_DiversityType__c.containsIgnoreCase('Veteran Owned Business Enterprise'))
                           Select7 = True;
                           if(atta.AS_DiversityType__c.containsIgnoreCase('Lesbian Gay Bisexual Transgender Business'))
                           Select8 = True;
                           if(atta.AS_DiversityType__c.containsIgnoreCase('Alaskan Native Corporation Owned Firm'))
                           Select9 = True;
                           if(atta.AS_DiversityType__c.containsIgnoreCase('Small Disadvantaged Business'))
                           Select10 = True;
                           if(atta.AS_DiversityType__c.containsIgnoreCase('Historically Underutilized Business Zone'))
                           Select11 = True;
                           if(atta.AS_DiversityType__c.containsIgnoreCase('Disabled Business Enterprise'))
                           Select12 = True;
                           if(atta.AS_DiversityType__c.containsIgnoreCase('Historically Black Colleges And Universities'))
                           Select13 = True;
                           if(atta.AS_DiversityType__c.containsIgnoreCase('SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS '))
                           Select14 = True;
                         }  
                         
                                                          // Gather BoothsDetails for Corporaters    
                                                          if(displayboothAdmin){
                                                                         ueserProfile = new LIST<User_Profile_Event__c>();
                                                                        
                                                                         ueserProfile = [SELECT ID, NAME, BoothAdmin_id__c, EV_id__r.EV_Title__c, BT_id__c , BT_id__r.MM_TableNo__c, 
                                                                                                         BT_id__r.BT_Location__c,Profile_id__r.PR_Name__c FROM User_Profile_Event__c WHERE BoothAdmin_id__c =: Userinfo.getUserId() AND Profile_id__r.PR_Name__c='BoothAdmin' ];
                                                                          
                                                          }  
                                                                
                                                                
                                                               
                                                                
                                        }catch(exception e){}
                                        
                                      system.debug('AAAAAAAAAAAAAAAAAAAAAAA       pk '+displayAttendee+' displayBoothAdmin  '+displayBoothAdmin );
                                         
                                      mbesettings = new LIST<Profile_Settings__c>();
                                
                                     
                                        if(displayAttendee){
                                         mbesettings = [Select MBECompanyhavefacility_partneroutsideUSA__c,Companyhaveafacility_partneroutsideUSA__c,Reference2__c,MBE_References2_Visible__c,Scope_of_Work__c,MBEScope_of_Work__c,Scope_of_Work2__c,MBEScope_of_Work2_Visible__c,Any_non_WBENC_awards_received__c,MBEAny_non_WBENC_awards_received_visible__c,Ethnicity__c,MBE_Ethnicity_Visible__c,MBE_Secondary_Email_Visible__c,Secondary_Email__c,p.Zip_Code__c, p.Year_in_Business__c, p.Work_phone__c, p.Work_Address__c, p.Website__c, p.Uploaded_Video__c, p.Uploaded_Company_Brochures__c, p.Title__c, p.SystemModstamp, p.State__c, p.Small_Business_IMAGE__c, p.Secondary_Business_Category__c, p.Salutation__c, p.Revenue_Range__c, p.References__c, p.Products_Services__c, p.Products_NOT_interested_visible__c, p.Primary_Business_Category__c, p.OwnerId, p.Number_Of_Employees__c, p.Name, p.NAICS_Codes__c, p.Mobile__c, p.Manufatures_Country__c, p.MBE_Zip_Code_Visible__c, p.MBE_Year_in_Business_Visible__c, p.MBE_Work_Phone_Visible__c, p.MBE_Work_Address_Visibility__c, p.MBE_Website_Visible__c, p.MBE_Uploaded_Video_Visible__c, p.MBE_Uploaded_Company_Brochures_Visible__c, p.MBE_Title_Visible__c, p.MBE_State_Visible__c, p.MBE_Small_Business_Image_Visible__c, p.MBE_Secondary_Business_Category_Visible__c, p.MBE_Salutation_Visible__c, p.MBE_Revenue_Range_Visible__c, p.MBE_References_Visible__c, p.MBE_Products_Services_Visible__c, p.MBE_Procurement_Needs_Visible__c, p.MBE_Primary_Business_Category_Visible__c, p.MBE_Number_Of_Employees_Visible__c, p.MBE_NAICS_CODES_Visible__c, p.MBE_Mobile_Phone_Visible__c, p.MBE_Manufatures_Country_Visible__c, p.MBE_LastName_Visible__c, p.MBE_Job_Title_Visible__c, p.MBE_Geographical_Region_Visible__c, p.MBE_GSA_Schedule_Contract_Number_Visible__c, p.MBE_First_Name_Visible__c, p.MBE_Email_Visible__c, p.MBE_Distributors_Country_Visible__c, p.MBE_DBA_Visible__c, p.MBE_Country_Visible__c, p.MBE_Company_Visible__c, p.MBE_Company_Logo_Visible__c, p.MBE_Commodities_Visible__c, p.MBE_City_Visible__c, p.MBE_Certifications_Visible__c, p.MBE_Certificate_Processed_by_RPO_Visible__c, p.MBE_Cage_Code_Visible__c, p.MBE_Business_Type_Visible__c, p.MBE_Business_Tax_ID_Visible__c, p.MBE_Business_Revenue_Visible__c, p.MBE_Business_Established_Date_Visible__c, p.MBE_Business_Duns_Number_Visible__c, p.MBE_Business_Description_Visible__c, p.MBE_BBB_Number_Visible__c, p.MBE_Address_2_Visible__c, p.MBE_Address_1_Visible__c, p.MBE_Additional_Company_videos_Visible__c, p.MBE_Additional_Company_Brouchers_Visible__c, p.Location__c, p.Last_Name__c,  p.LastModifiedDate, p.LastModifiedById,  p.KeyWords__c, p.Job_Title__c, p.IsDeleted, p.Id, p.Geographical_Region__c, p.GSA_Schedule_Contract_Number__c, p.First_Name__c, p.Event__c, p.Email_Id__c, p.Distributors_Country__c, p.DBA__c, p.CreatedDate, p.CreatedById, p.Country__c, p.Corporate_ZIP_Code_Visible__c, p.Corporate_Work_Address_Visible__c, p.Corporate_Website_Registration_Link_Vi__c, p.Corporate_Table_Room_No_Visible__c, p.Corporate_State_Visible__c, p.Corporate_Secondary_Business_Category_Vi__c, p.Corporate_Salutation_Visible__c, p.Corporate_Procurement_Visible__c, p.Corporate_Primary_Business_Category_Visi__c, p.Corporate_Phone_Visible__c, p.Corporate_NAICS_CODES_Visible__c, p.Corporate_Mobile_Phone_Visible__c, p.Corporate_Manufactures_Country_Visible__c, p.Corporate_Logo_Visible__c, p.Corporate_Location_Visible__c, p.Corporate_Job_Title_Visible__c, p.Corporate_Geographical_Region_Visible__c, p.Corporate_First_Name_Visible__c, p.Corporate_E_Mail_Visible__c, p.Corporate_Distributors_Country_Visible__c, p.Corporate_DBA_Visible__c, p.Corporate_Country_Visible__c, p.Corporate_Contact_Image_Visible__c, p.Corporate_Company_Visible__c, p.Corporate_Company_Logo_Visible__c, p.Corporate_Commodities_Visible__c, p.Corporate_City_Visible__c, p.Corporate_Certificate_Processed_by_RPO_V__c, p.Corporate_Business_Description_Visible__c, p.Corporate_BBB_Number_Visible__c, p.Corporate_Address_2_Visible__c, p.Corporate_Address_1_Visible__c, p.Corporate_Additional_Company_videos_Visi__c, p.Corporate_Additional_Company_Brouchers_V__c, p.Contact_Image__c, p.Company_Name__c, p.Company_Logo__c, p.Commodities__c, p.Certifications__c, p.Certificate_Processed_by_RPO__c, p.Cage_Code__c, p.Business_Type__c, p.Business_Tax_ID__c, p.Business_Revenue__c, p.Business_Established_Date__c, p.Business_Duns_Number__c, p.Business_Description__c, p.BBB_Number__c, p.Additional_Company_videos__c, p.Additional_Company_Brouchers__c,FaxNumber__c,FaxNumber_Visible__c,Business_Structure__c,Business_Structure_Visible__c,MBE_Salutation_Required__c,MBE_First_Name_Required__c,MBE_Title_Required__c,MBE_Mobile_Phone_Required__c,MBE_Company_Required__c,MBE_Work_Address_Required__c,MBE_Work_Phone_Required__c,MBE_NAICS_CODES_Required__c,MBE_Procurement_Needs_Required__c,MBE_Business_Description_Required__c,MBE_Small_Business_Image_Required__c,MBE_Commodities_Required__c,MBE_DBA_Required__c,MBE_Website_Required__c,MBE_Manufatures_Country_Required__c,MBE_Distributors_Country_Required__c,MBE_Additional_Company_Brouchers_Require__c,MBE_Uploaded_Company_Brochures_Required__c,MBE_Additional_Company_videos_Required__c,MBE_Uploaded_Video_Required__c,MBE_Company_Logo_Required__c,MBE_Business_Duns_Number_Required__c,MBE_Business_Established_Date_Required__c,MBE_BBB_Number_Required__c,MBE_Business_Revenue_Required__c,MBE_Revenue_Range_Required__c,MBE_Business_Tax_ID_Required__c,MBE_Cage_Code_Required__c,MBE_GSA_Schedule_Contract_Number_Require__c,MBE_Number_Of_Employees_Required__c,MBE_Primary_Business_Category_Required__c,MBE_Secondary_Business_Category_Required__c,MBE_Certifications_Required__c,MBE_Certificate_Processed_by_RPO_Require__c,MBE_Geographical_Region_Required__c,MBE_References_Required__c,MBE_Business_Type_Required__c,MBE_Email_Required__c,MBE_Year_in_Business_Required__c,Business_Structure_Required__c,FaxNumber_Required__c,MBE_Ethnicity_Required__c,MBE_Secondary_Email_Required__c,MBEAny_non_WBENC_awards_received_Require__c,MBECompanypartneroutsideUSA_Required__c ,Corporate_Additional_Company_Brouchers_R__c,Corporate_Additional_Company_videos_Reqi__c,Corporate_BBB_Number_Required__c,Corporate_Certificate_Processed_by_RPO_R__c,Corporate_Commodities_Required__c,Corporate_Company_Logo_Required__c,Corporate_Distributors_Country_Required__c,Corporate_exceptional_keywords_required__c,Corporate_Geographical_Region_Required__c,Corporate_Location_Required__c,Corporate_Manufactures_Country_Required__c,Corporate_Secondary_Business_Category_Re__c,Corporate_Table_Room_No_Requi__c,Corporate_Website_Registration_Link_Reqi__c,Corporate_Business_Description_Required__c,Corporate_Company_Required__c,Corporate_Contact_Image_Required__c,Corporate_DBA_Required__c,Corporate_E_Mail_Required__c,Corporate_First_Name_Required__c,Corporate_Job_Title_Required__c,Corporate_Mobile_Phone_Required__c,Corporate_NAICS_CODES_Required__c,Corporate_Phone_Required__c,Corporate_Primary_Business_Category_Reqi__c,Corporate_Procurement_Required__c,Corporate_Salutation_Required__c,Corporate_Work_Address_Required__c,Products_NOT_interested_Required__c From Profile_Settings__c p where  Event__r.id =:SelectEvent AND Name='MBE'];
                                        }else{
                                            mbesettings = [Select MBECompanyhavefacility_partneroutsideUSA__c,Companyhaveafacility_partneroutsideUSA__c,Reference2__c,MBE_References2_Visible__c,Scope_of_Work__c,MBEScope_of_Work__c,Scope_of_Work2__c,MBEScope_of_Work2_Visible__c,Any_non_WBENC_awards_received__c,MBEAny_non_WBENC_awards_received_visible__c, Ethnicity__c,MBE_Ethnicity_Visible__c,MBE_Secondary_Email_Visible__c,Secondary_Email__c,p.Zip_Code__c, p.Year_in_Business__c, p.Work_phone__c, p.Work_Address__c, p.Website__c, p.Uploaded_Video__c, p.Uploaded_Company_Brochures__c, p.Title__c, p.SystemModstamp, p.State__c, p.Small_Business_IMAGE__c, p.Secondary_Business_Category__c, p.Salutation__c, p.Revenue_Range__c, p.References__c, p.Products_Services__c, p.Products_NOT_interested_visible__c, p.Primary_Business_Category__c, p.OwnerId, p.Number_Of_Employees__c, p.Name, p.NAICS_Codes__c, p.Mobile__c, p.Manufatures_Country__c, p.MBE_Zip_Code_Visible__c, p.MBE_Year_in_Business_Visible__c, p.MBE_Work_Phone_Visible__c, p.MBE_Work_Address_Visibility__c, p.MBE_Website_Visible__c, p.MBE_Uploaded_Video_Visible__c, p.MBE_Uploaded_Company_Brochures_Visible__c, p.MBE_Title_Visible__c, p.MBE_State_Visible__c, p.MBE_Small_Business_Image_Visible__c, p.MBE_Secondary_Business_Category_Visible__c, p.MBE_Salutation_Visible__c, p.MBE_Revenue_Range_Visible__c, p.MBE_References_Visible__c, p.MBE_Products_Services_Visible__c, p.MBE_Procurement_Needs_Visible__c, p.MBE_Primary_Business_Category_Visible__c, p.MBE_Number_Of_Employees_Visible__c, p.MBE_NAICS_CODES_Visible__c, p.MBE_Mobile_Phone_Visible__c, p.MBE_Manufatures_Country_Visible__c, p.MBE_LastName_Visible__c, p.MBE_Job_Title_Visible__c, p.MBE_Geographical_Region_Visible__c, p.MBE_GSA_Schedule_Contract_Number_Visible__c, p.MBE_First_Name_Visible__c, p.MBE_Email_Visible__c, p.MBE_Distributors_Country_Visible__c, p.MBE_DBA_Visible__c, p.MBE_Country_Visible__c, p.MBE_Company_Visible__c, p.MBE_Company_Logo_Visible__c, p.MBE_Commodities_Visible__c, p.MBE_City_Visible__c, p.MBE_Certifications_Visible__c, p.MBE_Certificate_Processed_by_RPO_Visible__c, p.MBE_Cage_Code_Visible__c, p.MBE_Business_Type_Visible__c, p.MBE_Business_Tax_ID_Visible__c, p.MBE_Business_Revenue_Visible__c, p.MBE_Business_Established_Date_Visible__c, p.MBE_Business_Duns_Number_Visible__c, p.MBE_Business_Description_Visible__c, p.MBE_BBB_Number_Visible__c, p.MBE_Address_2_Visible__c, p.MBE_Address_1_Visible__c, p.MBE_Additional_Company_videos_Visible__c, p.MBE_Additional_Company_Brouchers_Visible__c, p.Location__c, p.Last_Name__c,  p.LastModifiedDate, p.LastModifiedById, p.KeyWords__c, p.Job_Title__c, p.IsDeleted, p.Id, p.Geographical_Region__c, p.GSA_Schedule_Contract_Number__c, p.First_Name__c, p.Event__c, p.Email_Id__c, p.Distributors_Country__c, p.DBA__c, p.CreatedDate, p.CreatedById, p.Country__c, p.Corporate_ZIP_Code_Visible__c, p.Corporate_Work_Address_Visible__c, p.Corporate_Website_Registration_Link_Vi__c, p.Corporate_Table_Room_No_Visible__c, p.Corporate_State_Visible__c, p.Corporate_Secondary_Business_Category_Vi__c, p.Corporate_Salutation_Visible__c, p.Corporate_Procurement_Visible__c, p.Corporate_Primary_Business_Category_Visi__c, p.Corporate_Phone_Visible__c, p.Corporate_NAICS_CODES_Visible__c, p.Corporate_Mobile_Phone_Visible__c, p.Corporate_Manufactures_Country_Visible__c, p.Corporate_Logo_Visible__c, p.Corporate_Location_Visible__c, p.Corporate_Job_Title_Visible__c, p.Corporate_Geographical_Region_Visible__c, p.Corporate_First_Name_Visible__c, p.Corporate_E_Mail_Visible__c, p.Corporate_Distributors_Country_Visible__c, p.Corporate_DBA_Visible__c, p.Corporate_Country_Visible__c, p.Corporate_Contact_Image_Visible__c, p.Corporate_Company_Visible__c, p.Corporate_Company_Logo_Visible__c, p.Corporate_Commodities_Visible__c, p.Corporate_City_Visible__c, p.Corporate_Certificate_Processed_by_RPO_V__c, p.Corporate_Business_Description_Visible__c, p.Corporate_BBB_Number_Visible__c, p.Corporate_Address_2_Visible__c, p.Corporate_Address_1_Visible__c, p.Corporate_Additional_Company_videos_Visi__c, p.Corporate_Additional_Company_Brouchers_V__c, p.Contact_Image__c, p.Company_Name__c, p.Company_Logo__c, p.Commodities__c,  p.Certifications__c, p.Certificate_Processed_by_RPO__c, p.Cage_Code__c, p.Business_Type__c, p.Business_Tax_ID__c, p.Business_Revenue__c, p.Business_Established_Date__c, p.Business_Duns_Number__c, p.Business_Description__c, p.BBB_Number__c,  p.Additional_Company_videos__c, p.Additional_Company_Brouchers__c,FaxNumber__c,FaxNumber_Visible__c,Business_Structure__c,Business_Structure_Visible__c,Corporate_exceptional_keywords_visible__c,exceptional_keywords__c,MBE_Salutation_Required__c,MBE_First_Name_Required__c,MBE_Title_Required__c,MBE_Mobile_Phone_Required__c,MBE_Company_Required__c,MBE_Work_Address_Required__c,MBE_Work_Phone_Required__c,MBE_NAICS_CODES_Required__c,MBE_Procurement_Needs_Required__c,MBE_Business_Description_Required__c,MBE_Small_Business_Image_Required__c,MBE_Commodities_Required__c,MBE_DBA_Required__c,MBE_Website_Required__c,MBE_Manufatures_Country_Required__c,MBE_Distributors_Country_Required__c,MBE_Additional_Company_Brouchers_Require__c,MBE_Uploaded_Company_Brochures_Required__c,MBE_Additional_Company_videos_Required__c,MBE_Uploaded_Video_Required__c,MBE_Company_Logo_Required__c,MBE_Business_Duns_Number_Required__c,MBE_Business_Established_Date_Required__c,MBE_BBB_Number_Required__c,MBE_Business_Revenue_Required__c,MBE_Revenue_Range_Required__c,MBE_Business_Tax_ID_Required__c,MBE_Cage_Code_Required__c,MBE_GSA_Schedule_Contract_Number_Require__c,MBE_Number_Of_Employees_Required__c,MBE_Primary_Business_Category_Required__c,MBE_Secondary_Business_Category_Required__c,MBE_Certifications_Required__c,MBE_Certificate_Processed_by_RPO_Require__c,MBE_Geographical_Region_Required__c,MBE_References_Required__c,MBE_Business_Type_Required__c,MBE_Email_Required__c,MBE_Year_in_Business_Required__c,Business_Structure_Required__c,FaxNumber_Required__c,MBE_Ethnicity_Required__c,MBE_Secondary_Email_Required__c,MBEAny_non_WBENC_awards_received_Require__c,MBECompanypartneroutsideUSA_Required__c ,Corporate_Additional_Company_Brouchers_R__c,Corporate_Additional_Company_videos_Reqi__c,Corporate_BBB_Number_Required__c,Corporate_Certificate_Processed_by_RPO_R__c,Corporate_Commodities_Required__c,Corporate_Company_Logo_Required__c,Corporate_Distributors_Country_Required__c,Corporate_exceptional_keywords_required__c,Corporate_Geographical_Region_Required__c,Corporate_Location_Required__c,Corporate_Manufactures_Country_Required__c,Corporate_Secondary_Business_Category_Re__c,Corporate_Table_Room_No_Requi__c,Corporate_Website_Registration_Link_Reqi__c,Corporate_Business_Description_Required__c,Corporate_Company_Required__c,Corporate_Contact_Image_Required__c,Corporate_DBA_Required__c,Corporate_E_Mail_Required__c,Corporate_First_Name_Required__c,Corporate_Job_Title_Required__c,Corporate_Mobile_Phone_Required__c,Corporate_NAICS_CODES_Required__c,Corporate_Phone_Required__c,Corporate_Primary_Business_Category_Reqi__c,Corporate_Procurement_Required__c,Corporate_Salutation_Required__c,Corporate_Work_Address_Required__c,Products_NOT_interested_Required__c From Profile_Settings__c p where  Event__r.id =:SelectEvent AND Name='Corporate'];
                                     
                                     } 
                                     
                                          
                                
    
           if(mbesettings.size()>0){
               pset = mbesettings[0];
           }
           //////////////////////////////////////////////////////////////
           
           
         options = new List<selectOption>(); 

        options.add(new selectOption('', '--None--'));
        options.add(new selectOption('Astra Women’s Business Alliance', 'Astra Women’s Business Alliance'));
        options.add(new selectOption('Center for Women & Enterprise', 'Center for Women & Enterprise'));
        options.add(new selectOption('Great Lakes Women Business Council', 'Great Lakes Women Business Council'));
        options.add(new selectOption('Greater Women Business Council', 'Greater Women Business Council'));
        options.add(new selectOption('Ohio River Valley Women Business Council', 'Ohio River Valley Women Business Council'));
        options.add(new selectOption('Women President Educational Organization - DC', 'Women President Educational Organization - DC'));
        options.add(new selectOption('Women President Educational Organization - New York', 'Women President Educational Organization - New York'));
        options.add(new selectOption('Women Business Council - Southwest', 'Women Business Council - Southwest'));
        options.add(new selectOption('Women Business Development Center - Chicago', 'Women Business Development Center - Chicago'));
        options.add(new selectOption('Women Business Development Center -- Florida', 'Women Business Development Center -- Florida'));
        options.add(new selectOption('Women Business Enterprise Alliance', 'Women Business Enterprise Alliance'));
        options.add(new selectOption('Women Business Enterprise Council - West', 'Women Business Enterprise Council - West'));
        options.add(new selectOption('Women Business Enterprise Council PA-DE-sNJ', 'Women Business Enterprise Council PA-DE-sNJ'));
        options.add(new selectOption('Women Business Enterprise Council South', 'Women Business Enterprise Council South'));
    }
    public list<MBE_Profile__c> mbepro {get ; set ;}
    public boolean Profile1 {get ; set ;}
     public boolean Profile2 {get ; set ;}
     public list<string> commodities {get ; set ;}
     
     
    public void attendeedetails(){ 
    attachments = new list<Attachment> ();
    cyoutubevideo = new Custom_Widget__c ();
     event = [SELECT id,Is_Webank_event__c,owner.username,owner.id from Event__c WHERE id =:SelectEvent];
       ueserProfile = new List<User_Profile_Event__c>();
       ueserProfile = [SELECT  ID, NAME, BoothAdmin_id__c, EV_id__r.EV_Title__c, BT_id__c , BT_id__r.MM_TableNo__c, 
                                         BT_id__r.BT_Location__c,Profile_id__r.PR_Name__c FROM User_Profile_Event__c WHERE BoothAdmin_id__c =: Userinfo.getUserId() AND (Profile_id__r.PR_Name__c='Boothadmin' ) AND  EV_id__r.id = :SelectEvent ];
                          
                    
       atta = new AttendeeSummary__c();
       mbepro = new list<MBE_Profile__c> ();
      mbeproSingle = new MBE_Profile__c();
       
       Profile1  =false;
       Profile2  = false;
       
       if((event.Is_Webank_event__c == True && displayAttendee==true )){
          system.debug('SSSSSSSSSSSSSSSS 2222'+Profile1  +'Profile2  '+Profile2 );
             Profile1 = false;
             Profile2 = true; 
                    
      /// mbeproSingle = new MBE_Profile__c();
         atta=[Select Companyhaveafacility_partneroutsideUSA__c,Any_non_WBENC_awards_received__c,References2__c,Scope_of_Work__c,Scope_of_Work2__c,Ethnicity__c,Business_Structure__c,Year_in_business__c,AS_Secondary_Email__c,a.As_prefixNew__c ,a.As_SuffixNew__c,a.As_Shipping_Country__c,a.As_Shipping_States__c,a.SystemModstamp, a.OwnerId, a.Name, a.LastModifiedDate, a.LastModifiedById,a.AS_uniqueField__c,
                          a.LastActivityDate, a.IsDeleted, a.Id, a.CreatedDate, a.CreatedById, Exhibitor_company_imageUrl__c,
                          a.AS_WorkZipCode__c, a.AS_WorkState__c, a.AS_WorkPoBox__c, a.AS_WorkPhone__c, 
                          a.AS_WorkCountry__c, a.AS_WorkCity__c, a.AS_WorkAddress2__c, a.AS_WorkAddress1__c, Keywords__c,
                          a.AS_WebsiteUrl__c, a.AS_Title__c, a.AS_ThroughEventBrite__c, a.AS_Suffix__c, 
                          a.AS_ShippingZipcode__c, a.AS_ShippingState__c, a.AS_ShippingPoBox__c, a.AS_ShippingPhone__c, 
                          a.AS_ShippingCountry__c, a.AS_ShippingCity__c, a.AS_ShippingAddress2__c, a.AS_ShippingAddress1__c,
                          a.AS_SecondaryBusinessCategory1__c, a.AS_PrimaryBusinessCategory1__c, a.AS_Prefix__c, a.Company_Certifications__c,
                          a.AS_NumberOfEmployees__c, a.AS_NAICSCode_5__c, a.AS_NAICSCode_4__c, a.AS_NAICSCode_3__c,
                          a.AS_NAICSCode6__c,a.AS_NAICSCode7__c,a.AS_NAICSCode8__c,a.AS_NAICSCode9__c, 
                          a.AS_NAICSCode_2__c, a.AS_NAICSCode_1__c, a.AS_LastName__c, a.AS_ImageUrl__c, a.AS_HomeZipcode__c,
                          a.AS_HomeState__c, a.AS_HomePoBox__c, a.AS_HomePhone__c, a.AS_HomeCountry__c, a.AS_HomeCity__c,
                          a.AS_HomeAddress2__c, a.AS_HomeAddress1__c, a.AS_Gender__c, a.AS_FirstName__c, a.AS_FaxNumber__c,
                          a.AS_Email__c, a.AS_DiversityType__c, a.AS_Company__c, a.AS_CellPhone__c, a.AS_CageCode__c,a.GSA_Schedule__c,
                          a.AS_BusinessRevenue__c, a.AS_BusinessEstablishedDate__c, a.AS_BusinessDescription__c, a.Business_type__c,Exceptional_Key_Words__c,
                          a.AS_BlogUrl__c, a.AS_BirthDate__c, a.AS_Age__c,a.AS_Work_Country__c,a.AS_Work_States__c,a.As_Home_Country__c,a.As_Home_State__c,AS_BusinessTaxId__c,AS_WorkZip__c,AS_HomeZip__c,AS_shippingzip__c,
                          a.References__c,a.Revenue_Range__c,a.distribution_Country__c,a.Manufactures_Country__c,a.DBA__c,a.BBB_Number__c,a.Commodity_1__c,a.Commodity_2__c,a.Commodity_3__c,a.Commodity_4__c,a.Commodity_5__c,a.Commodity_6__c,a.Commodity_7__c,a.Commodity_8__c,a.Commodity_9__c,a.Geographical_Region__c,a.Certificate_Processed_by_RPO__c,
                          AS_BusinessDunsNumber__c,(SELECT Id, Name,Description,ContentType FROM Attachments),(select id,YouTubeId_c__c From Widgets__r) From AttendeeSummary__c a where a.AS_Email__c =:userInfo.getuserName()];
                       
        mbepro= [Select  a.Companyhaveafacility_partneroutsideUSA__c,a.Any_non_WBENC_awards_received__c,a.References2__c,a.Scope_of_Work__c,a.Ethnicity__c,Scope_of_Work2__c,a.AS_Secondary_Email__c,  a.As_prefixNew__c ,a.As_SuffixNew__c,a.As_Shipping_Country__c,a.As_Shipping_States__c,a.SystemModstamp, a.OwnerId, a.Name, a.LastModifiedDate, a.LastModifiedById,
                          a.LastActivityDate, a.IsDeleted, a.Id, a.CreatedDate, a.CreatedById, Exhibitor_company_imageUrl__c,
                          a.AS_WorkZipCode__c,a.AS_WorkPhone__c, 
                          a.AS_WorkCity__c, a.AS_WorkAddress2__c, a.AS_WorkAddress1__c, Key_Words__c,
                          a.AS_WebsiteUrl__c, a.AS_Title__c, 
                          a.AS_ShippingZipcode__c, a.AS_ShippingState__c, a.AS_ShippingPoBox__c, a.AS_ShippingPhone__c, 
                          a.AS_ShippingCity__c, a.AS_ShippingAddress2__c, a.AS_ShippingAddress1__c,
                          a.AS_SecondaryBusinessCategory1__c, a.AS_PrimaryBusinessCategory1__c,
                          a.AS_NumberOfEmployees__c, a.AS_NAICSCode_5__c, a.AS_NAICSCode_4__c, a.AS_NAICSCode_3__c, 
                          a.AS_NAICSCode_2__c, a.AS_NAICSCode_1__c, a.AS_LastName__c, a.AS_ImageUrl__c,
                          a.AS_HomePhone__c,a.AS_HomeCity__c,
                          a.AS_HomeAddress2__c, a.AS_HomeAddress1__c, a.AS_Gender__c, a.AS_FirstName__c, a.AS_FaxNumber__c,
                          a.AS_Email__c, a.AS_DiversityType__c, a.AS_Company__c, a.AS_CellPhone__c, a.AS_CageCode__c,a.GSA_Schedule__c,
                          a.AS_BusinessRevenue__c, a.AS_BusinessEstablishedDate__c, a.AS_BusinessDescription__c, a.Business_type__c,Exceptional_Key_Words__c,
                          a.AS_BlogUrl__c, a.AS_BirthDate__c, a.AS_Age__c,a.AS_Work_Country__c,a.AS_Work_States__c,a.As_Home_Country__c,a.As_Home_State__c,AS_WorkZip__c,AS_HomeZip__c,
                          a.References__c,a.Revenue_Range__c,a.distribution_Country__c,a.Manufactures_Country__c,a.DBA__c,a.BBB_Number__c,a.Commodity_1__c,a.Commodity_2__c,a.Commodity_3__c,a.Commodity_4__c,a.Commodity_5__c,a.Commodity_6__c,a.Commodity_7__c,a.Commodity_8__c,a.Commodity_9__c,a.Geographical_Region__c,a.Certificate_Processed_by_RPO__c,
                          a.AS_NAICSCode6__c,a.AS_NAICSCode7__c,a.AS_NAICSCode8__c,a.AS_NAICSCode9__c,
                          AS_BusinessDunsNumber__c,AS_BusinessTaxId__c,Business_Structure__c,Company_Certifications__c,Year_in_business__c,FaxNumber__c,(select id,YouTubeId_c__c From Custom_Widgets__r),(SELECT Id, Name,Description,ContentType FROM Attachments) from MBE_Profile__c a Where a.AttendeeSummary__r.AS_Email__c =:userInfo.getuserName() AND a.Event_Organizer_Id__c=:event.owner.username];
                          selectedregions = new list<string>();
                         
                           if(mbepro.size()>0){
                             mbeproSingle =mbepro[0]; 
                             SelectValAs = mbepro[0].Certificate_Processed_by_RPO__c;
                          }
                           list<string> sts = new list<string>();
                                if(mbepro[0].Geographical_Region__c != null && mbepro[0].Geographical_Region__c != ''){
                                        sts = mbepro[0].Geographical_Region__c.split(',');
                                        selectedregions.addall(sts);
                                    }
            system.debug(mbepro);
             attachments = [SELECT Id, Name,Description,ContentType FROM Attachment where parentId=:mbepro[0].id];
           
       
         }
         else{
               system.debug('SSSSSSSSSSSSSSSS '+Profile1  +'Profile2  '+Profile2 );
               Profile1 = true;
               Profile2 = false;   
              atta=[Select Companyhaveafacility_partneroutsideUSA__c,Any_non_WBENC_awards_received__c,References2__c,Scope_of_Work__c,Scope_of_Work2__c,Ethnicity__c,Business_Structure__c,Year_in_business__c,AS_Secondary_Email__c,a.As_prefixNew__c ,a.As_SuffixNew__c,a.As_Shipping_Country__c,a.As_Shipping_States__c,a.SystemModstamp, a.OwnerId, a.Name, a.LastModifiedDate, a.LastModifiedById,a.AS_uniqueField__c,
                          a.LastActivityDate, a.IsDeleted, a.Id, a.CreatedDate, a.CreatedById, Exhibitor_company_imageUrl__c,
                          a.AS_WorkZipCode__c, a.AS_WorkState__c, a.AS_WorkPoBox__c, a.AS_WorkPhone__c, 
                          a.AS_WorkCountry__c, a.AS_WorkCity__c, a.AS_WorkAddress2__c, a.AS_WorkAddress1__c, Keywords__c,
                          a.AS_WebsiteUrl__c, a.AS_Title__c, a.AS_ThroughEventBrite__c, a.AS_Suffix__c, 
                          a.AS_ShippingZipcode__c, a.AS_ShippingState__c, a.AS_ShippingPoBox__c, a.AS_ShippingPhone__c, 
                          a.AS_ShippingCountry__c, a.AS_ShippingCity__c, a.AS_ShippingAddress2__c, a.AS_ShippingAddress1__c,
                          a.AS_SecondaryBusinessCategory1__c, a.AS_PrimaryBusinessCategory1__c, a.AS_Prefix__c, a.Company_Certifications__c,
                          a.AS_NumberOfEmployees__c, a.AS_NAICSCode_5__c, a.AS_NAICSCode_4__c, a.AS_NAICSCode_3__c,
                          a.AS_NAICSCode6__c,a.AS_NAICSCode7__c,a.AS_NAICSCode8__c,a.AS_NAICSCode9__c, 
                          a.AS_NAICSCode_2__c, a.AS_NAICSCode_1__c, a.AS_LastName__c, a.AS_ImageUrl__c, a.AS_HomeZipcode__c,
                          a.AS_HomeState__c, a.AS_HomePoBox__c, a.AS_HomePhone__c, a.AS_HomeCountry__c, a.AS_HomeCity__c,
                          a.AS_HomeAddress2__c, a.AS_HomeAddress1__c, a.AS_Gender__c, a.AS_FirstName__c, a.AS_FaxNumber__c,
                          a.AS_Email__c, a.AS_DiversityType__c, a.AS_Company__c, a.AS_CellPhone__c, a.AS_CageCode__c,a.GSA_Schedule__c,
                          a.AS_BusinessRevenue__c, a.AS_BusinessEstablishedDate__c, a.AS_BusinessDescription__c, a.Business_type__c,Exceptional_Key_Words__c,
                          a.AS_BlogUrl__c, a.AS_BirthDate__c, a.AS_Age__c,a.AS_Work_Country__c,a.AS_Work_States__c,a.As_Home_Country__c,a.As_Home_State__c,AS_BusinessTaxId__c,AS_WorkZip__c,AS_HomeZip__c,AS_shippingzip__c,
                          a.References__c,a.Revenue_Range__c,a.distribution_Country__c,a.Manufactures_Country__c,a.DBA__c,a.BBB_Number__c,a.Commodity_1__c,a.Commodity_2__c,a.Commodity_3__c,a.Commodity_4__c,a.Commodity_5__c,a.Commodity_6__c,a.Commodity_7__c,a.Commodity_8__c,a.Commodity_9__c,a.Geographical_Region__c,a.Certificate_Processed_by_RPO__c,
                          AS_BusinessDunsNumber__c,(SELECT Id, Name,Description,ContentType FROM Attachments),(select id,YouTubeId_c__c From Widgets__r) From AttendeeSummary__c a where a.AS_Email__c =:userInfo.getuserName()];
                          selectedregions = new list<string>();
                            list<string> sts = new list<string>();
                                if(atta.Geographical_Region__c != null && atta.Geographical_Region__c != ''){
                                        sts = atta.Geographical_Region__c.split(',');
                                        selectedregions.addall(sts);
                                    }
                           system.debug(atta);
       
       }
      
       system.debug('PPPPPPPPPPPPPPPPPPPPPPP '+displayBoothAdmin +' displayAttendee   '+displayAttendee   +'   profile1  '+profile1 +'    profile2 '+profile2 );
       }
      
         Public Void saveDiversity(){
            
            
            if(Select0 == TRUE)
            selValue.add('Minority Owned Business Enterprise');
            if(Select1== TRUE)
            selValue.add('Disadvantaged Business Enterprise');
            if(Select2== TRUE)
            selValue.add('Service Disabled Veteran Business Enterprise');
            if(Select3== TRUE)
            selValue.add('Small Business Enterprise');
            if(Select4== TRUE)
            selValue.add('Ability One');
            if(Select5== TRUE)
            selValue.add('Woman Owned Business Enterprise');
            if(Select6== TRUE)
            selValue.add('SBA 8(A) Program');
            if(Select7== TRUE)
            selValue.add('Veteran Owned Business Enterprise');
            if(Select8== TRUE)
            selValue.add('Lesbian Gay Bisexual Transgender Business');
            if(Select9== TRUE)
            selValue.add('Alaskan Native Corporation Owned Firm');
            if(Select10== TRUE)
            selValue.add('Small Disadvantaged Business');
            if(Select11== TRUE)
            selValue.add('Historically Underutilized Business Zone');
            if(Select12== TRUE)
            selValue.add('Disabled Business Enterprise');
            if(Select13== TRUE)
            selValue.add('Historically Black Colleges And Universities');
            if(Select14== TRUE)
            selValue.add('SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS ');
            
            selectedvaluesfordiversity= '';
            for(string s: selValue)
                {
                    selectedvaluesfordiversity+=s+';';
            
                }
            atta.AS_DiversityType__c = selectedvaluesfordiversity;
            }
        
        public class inn{
         public List<SelectOption> optionsevediversityInn {get;set;}
         public List<string> optionsAttdiversityInn {get;set;}
         public List<SelectOption> optionsevediversityInn2 {get;set;}
         public List<string> optionsAttdiversityInn2 {get;set;}
         public Id iInn{get;set;}
         public string eventName{get;set;}
         public inn(string s,List<string> l1,List<selectOption> l2,List<selectOption> l3,id i,List<string> l4){
         
         optionsAttdiversityInn = new  List<string>();
         optionsattdiversityInn2 = new  List<string>();
         optionsevediversityInn = new List<SelectOption>();
         optionsevediversityInn2 = new List<SelectOption>();
         
         
         this.eventName =s;
         this.optionsAttdiversityInn =l1;
         this.optionsAttdiversityInn2 =l4;
         this.optionsevediversityInn =l2;
         this.optionsevediversityInn2 =l3;
         this.iInn =i;
         }
        }
        Public Attachment getmyfile()
    {
        myfile = new Attachment();
        return myfile;
    }   
        
     public PageReference save() {
         system.debug('33333333333333333 11111 ');
       saveDiversity();
       system.debug('33333333333333333 '+atta.keywords__c);
       naicsalertbool=false;
       errorStringBool = FALSE;
       naicsselctdids =ApexPages.currentPage().getParameters().get('choose');
       system.debug('ddddddddddd ffffffffffff gg'+naicschangeselctdids );
   try{       
      if(selectedregions.size() != 0){
          atta.Geographical_Region__c = '';
      for(string st1 : selectedregions){
      
      atta.Geographical_Region__c += st1+',';
      
      }
      }     
      if(naicschangeselctdids != NULL){  
           naicscods= new list<string>();
           naicscods=naicschangeselctdids.split('-');
           system.debug('shruthi shruhti shruthi 11111111111' + naicscods.size());           
            system.debug('ddddddddddddddddd ' +  atta.As_NAICSCode_1__c );
            
            if(naicscods.size() == 2){
             atta.As_NAICSCode_1__c = naicscods[1].replace('&','-');
             atta.As_NAICSCode_2__c = '';
             atta.As_NAICSCode_3__c = '';
             atta.As_NAICSCode_4__c = '';
             atta.As_NAICSCode_5__c = '';
             atta.AS_NAICSCode6__c = '';
              atta.AS_NAICSCode7__c ='';
              atta.AS_NAICSCode8__c ='';
              atta.AS_NAICSCode9__c ='';
             
            }
            if(naicscods.size() == 3){
             atta.As_NAICSCode_1__c = naicscods[1].replace('&','-');
             atta.As_NAICSCode_2__c = naicscods[2].replace('&','-');
             atta.As_NAICSCode_3__c = '';
             atta.As_NAICSCode_4__c = '';
             atta.As_NAICSCode_5__c = '';
             atta.AS_NAICSCode6__c = '';
              atta.AS_NAICSCode7__c ='';
              atta.AS_NAICSCode8__c ='';
              atta.AS_NAICSCode9__c ='';
            }
            if(naicscods.size() == 4){
             atta.As_NAICSCode_1__c = naicscods[1].replace('&','-');
             atta.As_NAICSCode_2__c = naicscods[2].replace('&','-');
             atta.As_NAICSCode_3__c = naicscods[3].replace('&','-');
             atta.As_NAICSCode_4__c = '';
             atta.As_NAICSCode_5__c = '';
             atta.AS_NAICSCode6__c = '';
              atta.AS_NAICSCode7__c ='';
              atta.AS_NAICSCode8__c ='';
              atta.AS_NAICSCode9__c ='';
            }
            if(naicscods.size() == 5){
             atta.As_NAICSCode_1__c = naicscods[1].replace('&','-');
             atta.As_NAICSCode_2__c = naicscods[2].replace('&','-');
             atta.As_NAICSCode_3__c = naicscods[3].replace('&','-');
             atta.As_NAICSCode_4__c = naicscods[4].replace('&','-');
             atta.As_NAICSCode_5__c = '';
             atta.AS_NAICSCode6__c = '';
              atta.AS_NAICSCode7__c ='';
              atta.AS_NAICSCode8__c ='';
              atta.AS_NAICSCode9__c ='';
            }
             if(naicscods.size() == 6){
             atta.As_NAICSCode_1__c = naicscods[1].replace('&','-');
             atta.As_NAICSCode_2__c = naicscods[2].replace('&','-');
             atta.As_NAICSCode_3__c = naicscods[3].replace('&','-');
             atta.As_NAICSCode_4__c = naicscods[4].replace('&','-');
             atta.As_NAICSCode_5__c = naicscods[5].replace('&','-');
             atta.AS_NAICSCode6__c = '';
              atta.AS_NAICSCode7__c ='';
              atta.AS_NAICSCode8__c ='';
              atta.AS_NAICSCode9__c ='';
            }
           if(naicscods.size() == 7){
             atta.As_NAICSCode_1__c = naicscods[1].replace('&','-');
             atta.As_NAICSCode_2__c = naicscods[2].replace('&','-');
             atta.As_NAICSCode_3__c = naicscods[3].replace('&','-');
             atta.As_NAICSCode_4__c = naicscods[4].replace('&','-');
             atta.As_NAICSCode_5__c = naicscods[5].replace('&','-');
             atta.AS_NAICSCode6__c = naicscods[6].replace('&','-');
              atta.AS_NAICSCode7__c ='';
              atta.AS_NAICSCode8__c ='';
              atta.AS_NAICSCode9__c ='';
            }
           if(naicscods.size() == 8){
             atta.As_NAICSCode_1__c = naicscods[1].replace('&','-');
             atta.As_NAICSCode_2__c = naicscods[2].replace('&','-');
             atta.As_NAICSCode_3__c = naicscods[3].replace('&','-');
             atta.As_NAICSCode_4__c = naicscods[4].replace('&','-');
             atta.As_NAICSCode_5__c = naicscods[5].replace('&','-');
             atta.AS_NAICSCode6__c = naicscods[6].replace('&','-');
              atta.AS_NAICSCode7__c =naicscods[7].replace('&','-');
              atta.AS_NAICSCode8__c ='';
              atta.AS_NAICSCode9__c ='';
            }
           if(naicscods.size() == 9){
             atta.As_NAICSCode_1__c = naicscods[1].replace('&','-');
             atta.As_NAICSCode_2__c = naicscods[2].replace('&','-');
             atta.As_NAICSCode_3__c = naicscods[3].replace('&','-');
             atta.As_NAICSCode_4__c = naicscods[4].replace('&','-');
             atta.As_NAICSCode_5__c = naicscods[5].replace('&','-');
             atta.AS_NAICSCode6__c = naicscods[6].replace('&','-');
              atta.AS_NAICSCode7__c =naicscods[7].replace('&','-');
              atta.AS_NAICSCode8__c =naicscods[8].replace('&','-');
              atta.AS_NAICSCode9__c ='';
            }
           if(naicscods.size() == 10){
             atta.As_NAICSCode_1__c = naicscods[1].replace('&','-');
             atta.As_NAICSCode_2__c = naicscods[2].replace('&','-');
             atta.As_NAICSCode_3__c = naicscods[3].replace('&','-');
             atta.As_NAICSCode_4__c = naicscods[4].replace('&','-');
             atta.As_NAICSCode_5__c = naicscods[5].replace('&','-');
             atta.AS_NAICSCode6__c = naicscods[6].replace('&','-');
              atta.AS_NAICSCode7__c =naicscods[7].replace('&','-');
              atta.AS_NAICSCode8__c =naicscods[8].replace('&','-');
              atta.AS_NAICSCode9__c =naicscods[9].replace('&','-');
            }
            
   }
   if(commchangeselctdids != NULL){  
           commodities = new list<string>();
           commodities =commchangeselctdids.split('-');
           system.debug('shruthi shruhti shruthi 11111111111' + commodities.size());           
            
            
            if(commodities.size() == 2){
            
             atta.Commodity_1__c = commodities [1].replace('&','-');
             system.debug('ddddddddddddddddd ' +  atta.Commodity_1__c );
             atta.Commodity_2__c = '';
             atta.Commodity_3__c = '';
             atta.Commodity_4__c = '';
             atta.Commodity_5__c = '';
             atta.Commodity_6__c = '';
             atta.Commodity_7__c = '';
             atta.Commodity_8__c = '';
             atta.Commodity_9__c = '';
            }
            if(commodities.size() == 3){
                    system.debug('aaaaaaaaaaa ');   
             atta.Commodity_1__c = commodities [1].replace('&','-');
             atta.Commodity_2__c = commodities [2].replace('&','-');
             atta.Commodity_3__c = '';
             atta.Commodity_4__c = '';
             atta.Commodity_5__c = '';
             atta.Commodity_6__c = '';
             atta.Commodity_7__c = '';
             atta.Commodity_8__c = '';
             atta.Commodity_9__c = '';
            }
            if(commodities.size() == 4){
                    system.debug('aaaaaaaaaaa ');   
            atta.Commodity_1__c = commodities [1].replace('&','-');
             atta.Commodity_2__c = commodities [2].replace('&','-');
             atta.Commodity_3__c = commodities [3].replace('&','-');
             atta.Commodity_4__c = '';
             atta.Commodity_5__c = '';
             atta.Commodity_6__c = '';
             atta.Commodity_7__c = '';
             atta.Commodity_8__c = '';
             atta.Commodity_9__c = '';
            }
            if(commodities.size() == 5){
                    system.debug('aaaaaaaaaaa ');   
            atta.Commodity_1__c = commodities [1].replace('&','-');
             atta.Commodity_2__c = commodities [2].replace('&','-');
             atta.Commodity_3__c = commodities [3].replace('&','-');
             atta.Commodity_4__c = commodities [4].replace('&','-');
             atta.Commodity_5__c = '';
             atta.Commodity_6__c = '';
             atta.Commodity_7__c = '';
             atta.Commodity_8__c = '';
             atta.Commodity_9__c = '';
            }
             if(commodities.size() == 6){
                     system.debug('aaaaaaaaaaa ');   
            atta.Commodity_1__c = commodities [1].replace('&','-');
             atta.Commodity_2__c = commodities [2].replace('&','-');
             atta.Commodity_3__c = commodities [3].replace('&','-');
             atta.Commodity_4__c = commodities [4].replace('&','-');
             atta.Commodity_5__c = commodities [5].replace('&','-');
             atta.Commodity_6__c = '';
             atta.Commodity_7__c = '';
             atta.Commodity_8__c = '';
             atta.Commodity_9__c = '';
            }
            if(commodities.size() == 7){
                     system.debug('aaaaaaaaaaa ');   
            atta.Commodity_1__c = commodities [1].replace('&','-');
             atta.Commodity_2__c = commodities [2].replace('&','-');
             atta.Commodity_3__c = commodities [3].replace('&','-');
             atta.Commodity_4__c = commodities [4].replace('&','-');
             atta.Commodity_5__c = commodities [5].replace('&','-');
             atta.Commodity_6__c = commodities [6].replace('&','-');
             atta.Commodity_7__c = '';
             atta.Commodity_8__c = '';
             atta.Commodity_9__c = '';
            }
            if(commodities.size() == 8){
                     system.debug('aaaaaaaaaaa ');   
            atta.Commodity_1__c = commodities [1].replace('&','-');
             atta.Commodity_2__c = commodities [2].replace('&','-');
             atta.Commodity_3__c = commodities [3].replace('&','-');
             atta.Commodity_4__c = commodities [4].replace('&','-');
             atta.Commodity_5__c = commodities [5].replace('&','-');
             atta.Commodity_6__c = commodities [6].replace('&','-');
             atta.Commodity_7__c = commodities [7].replace('&','-');
             atta.Commodity_8__c = '';
             atta.Commodity_9__c = '';
            }
            if(commodities.size() == 9){
                     system.debug('aaaaaaaaaaa ');   
            atta.Commodity_1__c = commodities [1].replace('&','-');
             atta.Commodity_2__c = commodities [2].replace('&','-');
             atta.Commodity_3__c = commodities [3].replace('&','-');
             atta.Commodity_4__c = commodities [4].replace('&','-');
             atta.Commodity_5__c = commodities [5].replace('&','-');
             atta.Commodity_6__c = commodities [6].replace('&','-');
             atta.Commodity_7__c = commodities [7].replace('&','-');
             atta.Commodity_8__c = commodities [8].replace('&','-');
             atta.Commodity_9__c = '';
            }
            if(commodities.size() == 10){
                     system.debug('aaaaaaaaaaa ');   
            atta.Commodity_1__c = commodities [1].replace('&','-');
             atta.Commodity_2__c = commodities [2].replace('&','-');
             atta.Commodity_3__c = commodities [3].replace('&','-');
             atta.Commodity_4__c = commodities [4].replace('&','-');
             atta.Commodity_5__c = commodities [5].replace('&','-');
             atta.Commodity_6__c = commodities [6].replace('&','-');
             atta.Commodity_7__c = commodities [7].replace('&','-');
             atta.Commodity_8__c = commodities [8].replace('&','-');
             atta.Commodity_9__c = commodities [9].replace('&','-');
            }

         
       }  
         
         
  }catch(Exception e){} 
           try{ 
               if(myimageName != null){
                if (attendeeImage.size() != null) {
                     if (attendeeImage.size() <= 4024000) {
                        document  mydoc = new document();
                         mydoc.body = attendeeImage;
                         mydoc.folderid = UserInfo.getUserId();
                         mydoc.ispublic = true;
                         mydoc.Name = myimageName;
                         insert mydoc;
                         atta.AS_ImageUrl__c = mydoc.id;
                     } else {
                         imageerror = true;
                         
                     }
               }
            }
         }catch(Exception e){}
          
          try{ 
                if(myfile.name != null){
                 if ( myfile.body.size() != null) {
              
                   system.debug('33333333333@@@@@' + atta.id);
                    Attachment a = new Attachment(parentId = atta.id, name=myfile.name, body = myfile.body);
                     insert a;
                }  
              }
        }catch(Exception e){} 
      try{
        if(youtubevideo.YouTubeId_c__c != '' && youtubevideo.YouTubeId_c__c != null){
        List<string> ss =  new List<string> ();
        ss= youtubevideo.YouTubeId_c__c.split('src="');
        List<string> yy = new List<string> ();
        yy = ss[1].split('"');
        youtubevideo.YouTubeId_c__c = yy[0];
         youtubevideo.AttendeeSummary__c = atta.id;
         insert youtubevideo;
         }
       }catch(exception ed){}  
         system.debug('::::::::::::::::Video Id:::::::::::'+youtubevideo);
         try{ 
            system.debug('   GGGGGGGGGGGGGGGGGGGGGGGGGGGG  '+exhibitorImageName);
            if(exhibitorImageName != null){
                if (ExhibitorImage.size() != null) {
                     if (ExhibitorImage.size() <= 4024000) {
                        document  mydoc = new document();
                         mydoc.body = ExhibitorImage;
                         mydoc.folderid = UserInfo.getUserId();
                         mydoc.ispublic = true;
                         mydoc.Name = exhibitorImageName;
                         insert mydoc;
                         atta.Exhibitor_company_imageUrl__c = mydoc.id;
                     } else {
                         exebitorimageerror = true;
                         
                     }
               }
            }
        
   List<Event_Attendee_Mapping__c> updateList= new List<Event_Attendee_Mapping__c>();
   map<id,string> mapAejandDiversity = new map<id,string>();   
  if(diversityString != null && diversityString !=''){ 
       Event_Attendee_Mapping__c obj =mapIdandObject.get(atta.id);
       obj.DiversityType__c = diversityString ;
       database.update(obj,false);
  } 
   
   }catch(Exception e){}
          DataBase.SaveResult resl;
          Pagereference pg;
          
       if(!errorStringBool){
  
   
       
         resl = DataBase.update(atta, false);
           
           system.debug('AAAAAAAAAAAAAAAAAAAAAAAAAA      '+ resl);
          
        
        
          if(resl.isSuccess()){
          updateUser(resl.getId());
               pg = new pagereference('/Matchleads_Eventspage');
                pg.setredirect(true);   
          }
       }   
        
       return pg;
    }
    
    public PageReference savepro(){
    system.debug('@@@@@@@@@@@@@@@@@@'+SelectValAs);
    naicsselctdids = '';
    naicsselctdids =ApexPages.currentPage().getParameters().get('choose');
       system.debug('ddddddddddd ffffffffffff gg '+diversityString );
        system.debug('shruthi shruhti shruthi 11111111111' +commchangeselctdids );    
   try{       
           
           
      if(naicschangeselctdids != NULL){  
           naicscods= new list<string>();
           naicscods=naicschangeselctdids.split('-');
           system.debug('shruthi shruhti shruthi 11111111111' + naicscods.size());           
            system.debug('ddddddddddddddddd ' +  atta.As_NAICSCode_1__c );
            
            if(naicscods.size() == 2){
             mbepro[0].As_NAICSCode_1__c = naicscods[1].replace('&','-');
             mbepro[0].As_NAICSCode_2__c = '';
             mbepro[0].As_NAICSCode_3__c = '';
             mbepro[0].As_NAICSCode_4__c = '';
             mbepro[0].As_NAICSCode_5__c = '';
             mbepro[0].AS_NAICSCode6__c = '';
              mbepro[0].AS_NAICSCode7__c ='';
              mbepro[0].AS_NAICSCode8__c ='';
              mbepro[0].AS_NAICSCode9__c ='';
            }
            if(naicscods.size() == 3){
             mbepro[0].As_NAICSCode_1__c = naicscods[1].replace('&','-');
             mbepro[0].As_NAICSCode_2__c = naicscods[2].replace('&','-');
             mbepro[0].As_NAICSCode_3__c = '';
             mbepro[0].As_NAICSCode_4__c = '';
             mbepro[0].As_NAICSCode_5__c = '';
             mbepro[0].AS_NAICSCode6__c = '';
              mbepro[0].AS_NAICSCode7__c ='';
              mbepro[0].AS_NAICSCode8__c ='';
              mbepro[0].AS_NAICSCode9__c ='';
            }
            if(naicscods.size() == 4){
             mbepro[0].As_NAICSCode_1__c = naicscods[1].replace('&','-');
             mbepro[0].As_NAICSCode_2__c = naicscods[2].replace('&','-');
             mbepro[0].As_NAICSCode_3__c = naicscods[3].replace('&','-');
             mbepro[0].As_NAICSCode_4__c = '';
             mbepro[0].As_NAICSCode_5__c = '';
             mbepro[0].AS_NAICSCode6__c = '';
              mbepro[0].AS_NAICSCode7__c ='';
              mbepro[0].AS_NAICSCode8__c ='';
              mbepro[0].AS_NAICSCode9__c ='';
            }
            if(naicscods.size() == 5){
             mbepro[0].As_NAICSCode_1__c = naicscods[1].replace('&','-');
             mbepro[0].As_NAICSCode_2__c = naicscods[2].replace('&','-');
             mbepro[0].As_NAICSCode_3__c = naicscods[3].replace('&','-');
             mbepro[0].As_NAICSCode_4__c = naicscods[4].replace('&','-');
             mbepro[0].As_NAICSCode_5__c = '';
             mbepro[0].AS_NAICSCode6__c = '';
              mbepro[0].AS_NAICSCode7__c ='';
              mbepro[0].AS_NAICSCode8__c ='';
              mbepro[0].AS_NAICSCode9__c ='';
             
            }
             if(naicscods.size() == 6){
             mbepro[0].As_NAICSCode_1__c = naicscods[1].replace('&','-');
             mbepro[0].As_NAICSCode_2__c = naicscods[2].replace('&','-');
             mbepro[0].As_NAICSCode_3__c = naicscods[3].replace('&','-');
             mbepro[0].As_NAICSCode_4__c = naicscods[4].replace('&','-');
             mbepro[0].As_NAICSCode_5__c = naicscods[5].replace('&','-');
             mbepro[0].AS_NAICSCode6__c = '';
              mbepro[0].AS_NAICSCode7__c ='';
              mbepro[0].AS_NAICSCode8__c ='';
              mbepro[0].AS_NAICSCode9__c ='';
            }
            if(naicscods.size() == 7){
             mbepro[0].As_NAICSCode_1__c = naicscods[1].replace('&','-');
             mbepro[0].As_NAICSCode_2__c = naicscods[2].replace('&','-');
             mbepro[0].As_NAICSCode_3__c = naicscods[3].replace('&','-');
             mbepro[0].As_NAICSCode_4__c = naicscods[4].replace('&','-');
             mbepro[0].As_NAICSCode_5__c = naicscods[5].replace('&','-');
              mbepro[0].AS_NAICSCode6__c = naicscods[6].replace('&','-');
              mbepro[0].AS_NAICSCode7__c ='';
              mbepro[0].AS_NAICSCode8__c ='';
              mbepro[0].AS_NAICSCode9__c ='';
            }
            if(naicscods.size() == 8){
             mbepro[0].As_NAICSCode_1__c = naicscods[1].replace('&','-');
             mbepro[0].As_NAICSCode_2__c = naicscods[2].replace('&','-');
             mbepro[0].As_NAICSCode_3__c = naicscods[3].replace('&','-');
             mbepro[0].As_NAICSCode_4__c = naicscods[4].replace('&','-');
             mbepro[0].As_NAICSCode_5__c = naicscods[5].replace('&','-');
              mbepro[0].AS_NAICSCode6__c = naicscods[6].replace('&','-');
              mbepro[0].AS_NAICSCode7__c =naicscods[7].replace('&','-');
              mbepro[0].AS_NAICSCode8__c ='';
              mbepro[0].AS_NAICSCode9__c ='';
            }
            if(naicscods.size() == 9){
             mbepro[0].As_NAICSCode_1__c = naicscods[1].replace('&','-');
             mbepro[0].As_NAICSCode_2__c = naicscods[2].replace('&','-');
             mbepro[0].As_NAICSCode_3__c = naicscods[3].replace('&','-');
             mbepro[0].As_NAICSCode_4__c = naicscods[4].replace('&','-');
             mbepro[0].As_NAICSCode_5__c = naicscods[5].replace('&','-');
              mbepro[0].AS_NAICSCode6__c = naicscods[6].replace('&','-');
              mbepro[0].AS_NAICSCode7__c =naicscods[7].replace('&','-');
              mbepro[0].AS_NAICSCode8__c =naicscods[8].replace('&','-');
              mbepro[0].AS_NAICSCode9__c ='';
            }
            if(naicscods.size() == 10){
             mbepro[0].As_NAICSCode_1__c = naicscods[1].replace('&','-');
             mbepro[0].As_NAICSCode_2__c = naicscods[2].replace('&','-');
             mbepro[0].As_NAICSCode_3__c = naicscods[3].replace('&','-');
             mbepro[0].As_NAICSCode_4__c = naicscods[4].replace('&','-');
             mbepro[0].As_NAICSCode_5__c = naicscods[5].replace('&','-');
              mbepro[0].AS_NAICSCode6__c = naicscods[6].replace('&','-');
              mbepro[0].AS_NAICSCode7__c =naicscods[7].replace('&','-');
              mbepro[0].AS_NAICSCode8__c =naicscods[8].replace('&','-');
              mbepro[0].AS_NAICSCode9__c =naicscods[9].replace('&','-');
            }
            
   }
  mbepro[0].Geographical_Region__c = '';
    for(string st : selectedregions){
       mbepro[0].Geographical_Region__c += st+',';
       }
 
     
      if(commchangeselctdids != NULL){  
           commodities = new list<string>();
           commodities =commchangeselctdids.split('-');
           system.debug('shruthi shruhti shruthi 11111111111' + commodities.size());           
            
            
            if(commodities.size() == 2){
                    system.debug('aaaaaaaaaaa ');   
             mbepro[0].Commodity_1__c = commodities [1].replace('&','-');
             system.debug('ddddddddddddddddd ' +  mbepro[0].Commodity_1__c );
             mbepro[0].Commodity_2__c = '';
             mbepro[0].Commodity_3__c = '';
             mbepro[0].Commodity_4__c = '';
             mbepro[0].Commodity_5__c = '';
              mbepro[0].Commodity_6__c = '';
             mbepro[0].Commodity_7__c = '';
             mbepro[0].Commodity_8__c = '';
             mbepro[0].Commodity_9__c = '';
            }
            if(commodities.size() == 3){
                    system.debug('aaaaaaaaaaa ');   
             mbepro[0].Commodity_1__c = commodities [1].replace('&','-');
             mbepro[0].Commodity_2__c = commodities [2].replace('&','-');
             mbepro[0].Commodity_3__c = '';
             mbepro[0].Commodity_4__c = '';
             mbepro[0].Commodity_5__c = '';
              mbepro[0].Commodity_6__c = '';
             mbepro[0].Commodity_7__c = '';
             mbepro[0].Commodity_8__c = '';
             mbepro[0].Commodity_9__c = '';
            }
            if(commodities.size() == 4){
                    system.debug('aaaaaaaaaaa ');   
            mbepro[0].Commodity_1__c = commodities [1].replace('&','-');
             mbepro[0].Commodity_2__c = commodities [2].replace('&','-');
             mbepro[0].Commodity_3__c = commodities [3].replace('&','-');
             mbepro[0].Commodity_4__c = '';
             mbepro[0].Commodity_5__c = '';
              mbepro[0].Commodity_6__c = '';
             mbepro[0].Commodity_7__c = '';
             mbepro[0].Commodity_8__c = '';
             mbepro[0].Commodity_9__c = '';
            }
            if(commodities.size() == 5){
                    system.debug('aaaaaaaaaaa ');   
            mbepro[0].Commodity_1__c = commodities [1].replace('&','-');
             mbepro[0].Commodity_2__c = commodities [2].replace('&','-');
             mbepro[0].Commodity_3__c = commodities [3].replace('&','-');
             mbepro[0].Commodity_4__c = commodities [4].replace('&','-');
             mbepro[0].Commodity_5__c = '';
              mbepro[0].Commodity_6__c = '';
             mbepro[0].Commodity_7__c = '';
             mbepro[0].Commodity_8__c = '';
             mbepro[0].Commodity_9__c = '';
            }
             if(commodities.size() == 6){
                     system.debug('aaaaaaaaaaa ');   
            mbepro[0].Commodity_1__c = commodities [1].replace('&','-');
             mbepro[0].Commodity_2__c = commodities [2].replace('&','-');
             mbepro[0].Commodity_3__c = commodities [3].replace('&','-');
             mbepro[0].Commodity_4__c = commodities [4].replace('&','-');
             mbepro[0].Commodity_5__c = commodities [5].replace('&','-');
              mbepro[0].Commodity_6__c = '';
             mbepro[0].Commodity_7__c = '';
             mbepro[0].Commodity_8__c = '';
             mbepro[0].Commodity_9__c = '';
            }
             if(commodities.size() == 7){
                     system.debug('aaaaaaaaaaa ');   
            mbepro[0].Commodity_1__c = commodities [1].replace('&','-');
             mbepro[0].Commodity_2__c = commodities [2].replace('&','-');
             mbepro[0].Commodity_3__c = commodities [3].replace('&','-');
             mbepro[0].Commodity_4__c = commodities [4].replace('&','-');
             mbepro[0].Commodity_5__c = commodities [5].replace('&','-');
              mbepro[0].Commodity_6__c = commodities [6].replace('&','-');
             mbepro[0].Commodity_7__c = '';
             mbepro[0].Commodity_8__c = '';
             mbepro[0].Commodity_9__c = '';
            }
             if(commodities.size() == 8){
                     system.debug('aaaaaaaaaaa ');   
            mbepro[0].Commodity_1__c = commodities [1].replace('&','-');
             mbepro[0].Commodity_2__c = commodities [2].replace('&','-');
             mbepro[0].Commodity_3__c = commodities [3].replace('&','-');
             mbepro[0].Commodity_4__c = commodities [4].replace('&','-');
             mbepro[0].Commodity_5__c = commodities [5].replace('&','-');
              mbepro[0].Commodity_6__c = commodities [6].replace('&','-');
             mbepro[0].Commodity_7__c = commodities [7].replace('&','-');
             mbepro[0].Commodity_8__c = '';
             mbepro[0].Commodity_9__c = '';
            }
             if(commodities.size() == 9){
                     system.debug('aaaaaaaaaaa ');   
            mbepro[0].Commodity_1__c = commodities [1].replace('&','-');
             mbepro[0].Commodity_2__c = commodities [2].replace('&','-');
             mbepro[0].Commodity_3__c = commodities [3].replace('&','-');
             mbepro[0].Commodity_4__c = commodities [4].replace('&','-');
             mbepro[0].Commodity_5__c = commodities [5].replace('&','-');
              mbepro[0].Commodity_6__c = commodities [6].replace('&','-');
             mbepro[0].Commodity_7__c = commodities [7].replace('&','-');
             mbepro[0].Commodity_8__c = '';
             mbepro[0].Commodity_9__c = '';
            }
             if(commodities.size() == 10){
                     system.debug('aaaaaaaaaaa ');   
            mbepro[0].Commodity_1__c = commodities [1].replace('&','-');
             mbepro[0].Commodity_2__c = commodities [2].replace('&','-');
             mbepro[0].Commodity_3__c = commodities [3].replace('&','-');
             mbepro[0].Commodity_4__c = commodities [4].replace('&','-');
             mbepro[0].Commodity_5__c = commodities [5].replace('&','-');
              mbepro[0].Commodity_6__c = commodities [6].replace('&','-');
             mbepro[0].Commodity_7__c = commodities [7].replace('&','-');
             mbepro[0].Commodity_8__c = commodities [8].replace('&','-');
             mbepro[0].Commodity_9__c = commodities [9].replace('&','-');
            }

            
   }
  }catch(Exception e){} 
     system.debug('AAAAAAAAAAAAAAAAAAAAAAAAAA    mbeproSingle  '+ mbeproSingle);
     
         try{ 
          if(myimageName != null){
                if (attendeeImage.size() != null) {
                     if (attendeeImage.size() <= 5024000) {
                        document  mydoc = new document();
                         mydoc.body = attendeeImage;
                         mydoc.folderid = UserInfo.getUserId();
                         mydoc.ispublic = true;
                         mydoc.Name = myimageName;
                         insert mydoc;
                         mbeproSingle.AS_ImageUrl__c = mydoc.id;
                     } else {
                         imageerror = true;
                         
                     }
               }
            }
         }catch(Exception e){}
     
     
     try{ 
            system.debug('   GGGGGGGGGGGGGGGGGGGGGGGGGGGG  '+exhibitorImageName);
            if(exhibitorImageName != null){
                if (ExhibitorImage.size() != null) {
                     if (ExhibitorImage.size() <= 4024000) {
                        document  mydoc = new document();
                         mydoc.body = ExhibitorImage;
                         mydoc.folderid = UserInfo.getUserId();
                         mydoc.ispublic = true;
                         mydoc.Name = exhibitorImageName;
                         insert mydoc;
                         mbeproSingle.Exhibitor_company_imageUrl__c = mydoc.id;
                     } else {
                         exebitorimageerror = true;
                         
                     }
               }
            } 
      }catch(Exception e){}
     saveDiversitypro();
     if(SelectValAs !=null && SelectValAs !=''){
       mbeproSingle.Certificate_Processed_by_RPO__c = SelectValAs ;
     }
      DataBase.SaveResult resl = DataBase.update(mbeproSingle, false);
  
             try{ 
                if(myfile.name != null){
                 if ( myfile.body.size() != null) {
                     Attachment a = new Attachment(parentId = mbeproSingle.id, name=myfile.name, body = myfile.body);
                     insert a;
                }  
              }
        }catch(Exception e){} 
  
  
  
  
   try{
           //saving video
                 if(cyoutubevideo.YouTubeId_c__c != '' && cyoutubevideo.YouTubeId_c__c != null){
                 List<string> ss =  new List<string> ();
                ss= cyoutubevideo.YouTubeId_c__c.split('src="');
                List<string> yy = new List<string> ();
                yy = ss[1].split('"');
                cyoutubevideo.YouTubeId_c__c = yy[0];
                     
                 cyoutubevideo.MBE_Profile__c = mbepro[0].id;
                 insert cyoutubevideo;
                 }
           
           system.debug('::::::::::::::::youtube:::::::::::::'+youtubevideo);
           }catch(exception e){}
  
  
  
   List<Event_Attendee_Mapping__c> updateList= new List<Event_Attendee_Mapping__c>();
   map<id,string> mapAejandDiversity = new map<id,string>();   
 if(diversityString != null && diversityString !=''){  
   Event_Attendee_Mapping__c obj =mapIdandObject.get(mbeproSingle.AttendeeSummary__c);
    obj.DiversityType__c = diversityString ;
    database.update(obj,false);  
  }         
           system.debug('AAAAAAAAAAAAAAAAAAAAAAAAAA      '+ resl);
          Pagereference pg = new pagereference('/Matchleads_Eventspage');
                pg.setredirect(true);
                       return pg;

  
    }
    
    
     Public Void saveDiversitypro(){
            
            
            if(Select0 == TRUE)
            selValue.add('Minority Owned Business Enterprise');
            if(Select1== TRUE)
            selValue.add('Disadvantaged Business Enterprise');
            if(Select2== TRUE)
            selValue.add('Service Disabled Veteran Business Enterprise');
            if(Select3== TRUE)
            selValue.add('Small Business Enterprise');
            if(Select4== TRUE)
            selValue.add('Ability One');
            if(Select5== TRUE)
            selValue.add('Woman Owned Business Enterprise');
            if(Select6== TRUE)
            selValue.add('SBA 8(A) Program');
            if(Select7== TRUE)
            selValue.add('Veteran Owned Business Enterprise');
            if(Select8== TRUE)
            selValue.add('Lesbian Gay Bisexual Transgender Business');
            if(Select9== TRUE)
            selValue.add('Alaskan Native Corporation Owned Firm');
            if(Select10== TRUE)
            selValue.add('Small Disadvantaged Business');
            if(Select11== TRUE)
            selValue.add('Historically Underutilized Business Zone');
            if(Select12== TRUE)
            selValue.add('Disabled Business Enterprise');
            if(Select13== TRUE)
            selValue.add('Historically Black Colleges And Universities');
            if(Select14== TRUE)
            selValue.add('SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS ');
            
            selectedvaluesfordiversity= '';
            for(string s: selValue)
                {
                    selectedvaluesfordiversity+=s+';';
            
                }
            mbeproSingle.AS_DiversityType__c = selectedvaluesfordiversity;
            }
    
    
    
  public void updatemath(){
      DataBase.SaveResult resl = DataBase.update(mbeproSingle, false);
  }  
    
    
    
    
    
    
    public String errorString{get; set;}
    public Boolean errorStringBool{get; set;}


@future
public static void updateUser(id attid){
AttendeeSummary__c attsummary = new AttendeeSummary__c();
attsummary =[select AS_FirstName__c ,AS_LastName__c ,AS_Company__c ,AS_Email__C,AS_WorkCity__c,AS_Work_States__c,AS_CellPhone__c ,AS_Work_Country__c from AttendeeSummary__c where id=:attid];
user u = new user();
u =[select firstName,lastName,companyName,City,States__c,Phone,Country__c  from user where username=:attsummary.AS_Email__C];
u.firstName =attsummary.AS_FirstName__c; 
u.lastName=attsummary.AS_LastName__c; 
u.CompanyName=attsummary.AS_Company__c; 
u.City =attsummary.AS_WorkCity__c; 
u.States__c=attsummary.AS_Work_States__c; 
u.Phone=attsummary.AS_CellPhone__c; 
u.Country__c =attsummary.AS_Work_Country__c;
dataBase.update(u,false); 
}

  

    public Pagereference CheckUser(){
    
    Pagereference pg = MM_Utility.checkLogInservice();
    
    return pg;
    
    }
    

   public string naicschangeselctdids {get;set;}
 public void naicscodesfun(){
      SYSTEM.DEBUG(' selected get '+ApexPages.currentPage().getParameters().get('naicccc'));
      IF(ApexPages.currentPage().getParameters().get('naicccc') != null){
          naicschangeselctdids =ApexPages.currentPage().getParameters().get('naicccc');
       }ELSE{
       naicschangeselctdids = NULL;
       }
       system.debug('44444444444444444 ' + naicschangeselctdids);
       
 
 }
 
 
 public string diversityString {get;set;}
 public void DiversityMeth(){
 
 diversityString = null;
     IF(ApexPages.currentPage().getParameters().get('divesities') != null && ApexPages.currentPage().getParameters().get('divesities') != ''){
          diversityString =ApexPages.currentPage().getParameters().get('divesities');
            integer index = diversityString.lastIndexOf(';');
            diversityString= diversityString.substring(0, index);
       }ELSE{
          diversityString = '';
       }
       system.debug('44444444444444444 Diversity' + ApexPages.currentPage().getParameters().get('divesities'));
       
             
 }

 
 
  public string commchangeselctdids{get;set;}
      public string commchangeids {get;set;}
 public void commodityfun(){
 commchangeselctdids = '';
      SYSTEM.DEBUG(' selected get '+ApexPages.currentPage().getParameters().get('comm'));
      IF(ApexPages.currentPage().getParameters().get('comm') != ''){
          commchangeselctdids =ApexPages.currentPage().getParameters().get('comm');
       }ELSE{
       commchangeselctdids = NULL;
       commchangeids = NULL;
       }
       system.debug('44444444444444444 ' + commchangeselctdids );
       //system.debug('44444444444444444 ' + naicschangeids);
       
             
 }

 
    Public string DelId {get;set;}
  public void delattachment(){
     SYSTEM.DEBUG(' selected get '+ApexPages.currentPage().getParameters().get('deletedId'));
     DelId = ApexPages.currentPage().getParameters().get('deletedId') ; 
     List<Attachment> attac = new List<Attachment>();
     attac = [select Id,Name From Attachment where id=: DelId ];
      SYSTEM.DEBUG(' ====================@@ '+attac );
     Database.DeleteResult[] DR_Dels = Database.delete(attac,True); 
   attendeedetails();  
 }
 public void delvideo(){
 DelId = ApexPages.currentPage().getParameters().get('deletedId1') ; 
     List<Custom_Widget__c> video = new List<Custom_Widget__c>();
     video = [select Id,Name From Custom_Widget__c where id=: DelId ];
      SYSTEM.DEBUG(' ====================@@ '+video);
     Database.DeleteResult[] DR_Dels = Database.delete(video,True);
     
     List<Widget__c> videocorp = new List<Widget__c>();
     videocorp = [select Id,Name From Widget__c where id=: DelId ];
      SYSTEM.DEBUG(' ====================@@ '+video);
     Database.DeleteResult[] DR_Dels1 = Database.delete(videocorp,True);
   attendeedetails();  
 }
 public PageReference delimage() {
  DelId = ApexPages.currentPage().getParameters().get('deletedId2') ; 
     List<document> imgdoc= new List<document>();
     imgdoc= [select Id,Name From document where id=: DelId ];
      Database.DeleteResult[] DR_Dels2 = Database.delete(imgdoc,True);
      List<MBE_Profile__c> mbepro= new List<MBE_Profile__c>();
     mbepro= [select Id,Name,Exhibitor_company_imageUrl__c,AS_ImageUrl__c From MBE_Profile__c where Exhibitor_company_imageUrl__c=: DelId or AS_ImageUrl__c =: DelId];
     if(mbepro.size()>0)
     {
       if(mbepro[0].Exhibitor_company_imageUrl__c==DelID)
       mbepro[0].Exhibitor_company_imageUrl__c=null;
       if(mbepro[0].AS_ImageUrl__c ==DelID)
       mbepro[0].AS_ImageUrl__c =null;
       Database.SaveResult[] DR_ups = Database.update(mbepro,True);
     }
      List<AttendeeSummary__c> attsum= new List<AttendeeSummary__c >();
     attsum= [select Id,Name,Exhibitor_company_imageUrl__c,AS_ImageUrl__c From AttendeeSummary__c where Exhibitor_company_imageUrl__c=: DelId or AS_ImageUrl__c =: DelId];
     if(attsum.size()>0)
     {
       if(attsum[0].Exhibitor_company_imageUrl__c==DelID)
       attsum[0].Exhibitor_company_imageUrl__c=null;
       if(attsum[0].AS_ImageUrl__c ==DelID)
       attsum[0].AS_ImageUrl__c =null;
       Database.SaveResult[] DR_ups = Database.update(attsum,True);
     }
     attendeedetails();  
        return null;
    }
 }