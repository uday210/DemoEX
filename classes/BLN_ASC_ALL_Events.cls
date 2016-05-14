@RestResource(urlMapping = '/BLN_ASC_ALL_Events/*')

global class BLN_ASC_ALL_Events{
  global static List<webContainer> webct {get ; set ;}
  @HttpPost
  global static List<webContainer> doPost() {
    String siteurl = Label.SiteURL;
    RestRequest req = RestContext.request;
    String appname = req.params.get('appname').toUpperCase();
    string orgid = UserInfo.getOrganizationId();
  webct = new List<webContainer> ();
  if(appname =='WEBSITE'){
   LIST<BLN_Event__c> AllEvents = [SELECT  Name,Venue_Name__c,ZipCode__c, Website_Url__c,  User_Company__c,organizer_id__r.Name,
                                         Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, Street2__c, Street1__c,  
                                          Start_Date__c, Phone_Number__c 
                                         ,PO_Box__c, Organizer_Email__c,Logo_URL__c, IsDeleted, Id, 
                                         Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c,  End_Date__c, 
                                          Description__c,BLN_Country__r.Short_Name__c,BLN_Country__r.Long_Name__c,City__c ,
                                         BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_State__r.Country__c,BLN_State__r.Country__r.Long_Name__c,BLN_State__r.Country__r.Short_Name__c,Show_Terms_Checkbox__c
                                        ,organizer_id__c, LinkedIn_URL__c,Event_Blog_URL__c 
                                          FROM BLN_Event__c WHERE ( Event_Status__c = 'Live' OR Event_Status__c = 'Completed') AND Event_Approved__c=true];
              system.debug('$$$$$$$'+AllEvents.size());
             for(BLN_Event__c evs : AllEvents){
                 string sdate='';
                string edate='';
                 string logo_url ='';
                string RegistrationLink = '';
                 if(evs.Start_Date__c != null && evs.End_Date__c != null && evs.Time_Zone__c !=null){
                 sdate=evs.Start_Date__c.format('yyyy-MM-dd hh:mm a',evs.Time_Zone__c);
                 edate=evs.End_Date__c.format('yyyy-MM-dd hh:mm a',evs.Time_Zone__c);
                 }
                 if(evs.Logo_URL__c !=null){
                 logo_url = siteurl+'/servlet/servlet.ImageServer?id='+evs.Logo_URL__c+'&oid='+orgid;
                 }
                 RegistrationLink =siteurl+ '/BLN_RegistrationDym?id='+evs.id;
                // ct.add(new Container(evs,'',evs.organizer_id__r.Name,evs.BLN_Country__r.Long_Name__c,evs.BLN_State__r.Long_Name__c,siteurl+'/servlet/servlet.ImageServer?id='+evs.Logo_URL__c+'&oid='+orgid,siteurl+'/BLN_Registration_Eventdex?id='+evs.id,sdate,edate));//,sdate,edate
            webct.add(new webContainer(evs.Street1__c,evs.Street2__c,evs.ZipCode__c,evs.Venue_Name__c,evs.Event_Status__c,evs.name,evs.organizer_id__r.Name,evs.BLN_Country__r.Long_Name__c,evs.BLN_State__r.Long_Name__c,logo_url,sdate,edate,RegistrationLink ));//,sdate,edate
             }
          }
          return  webct;
         
  }
  global class webContainer{
                          
       // public BLN_Event__c Events {get ; set ;}
        
         public string state{get ; set ;}
         public string country{get ; set ;}
         public string image{get ; set ;}
         public string company {get ; set ;}
         
         public string startDate{get;set;}
         public string endDate{get;set;}
        public string eventname{get;set;}
        public string eventstatus{get;set;}
        public string eventvenue{get;set;}
        public string street1{get;set;}
         public string street2{get;set;}
         public string zipcode{get;set;}
         public string registration_link{get;set;}
         
         public webContainer(string st1,string st2,string zip,string evevenue,string evestatus,string evename,string com,string cu,string st,string img,string sdate,string edate,string registrationlink){//,string sdate,string edate
        // Events = ev;
        street1 = st1;
        street2 = st2;
        zipcode = zip;
        eventname = evename;
         eventstatus = evestatus;
         eventvenue = evevenue;
         country = cu;
         state = st;
         image = img;
         company = com;
        
         this.startDate=sdate;
         this.endDate=edate;
         registration_link=registrationlink;
                
                }
         public webcontainer(){}
        
          
         
         }  
         
  
  }