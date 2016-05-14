public without sharing class MM_eventsCon {

    public PageReference CancelSchedule() {
    viewscheduleBool =false;
        return null;
    }


    public boolean viewscheduleBool { get; set; }
    public List<EventSchedule__c> eventscheduleDB{get;set;}


    public PageReference viewSchedule() {
     eventscheduleDB = new List<EventSchedule__c>();
      eventscheduleDB =[Select id,ES_Description__c,ES_EndDate__c,ES_EndTime__c,EV_id__c,MM_To_EAM__c,ES_Location__c,MM_Slot_EndTime__c,MM_Slot_Time__c,MM_Slot_Status__c,MM_slot_Date__c,MM_Slot_End_Time__c,MM_slot_StartTime__c,ES_Presenter__c,ES_ProgramName__c,ES_StartDate__c,ES_StartTime__c,MM_To_UPE__c from EventSchedule__c where EV_id__c=:SelectedEventId and MM_To_UPE__c=null and MM_To_EAM__c=null]; 
       system.debug('huiiiiiiiiiiiiiiiiiiiiiiii '+eventscheduleDB );
       viewscheduleBool =true;
       return null;
    }

public Boolean recordPermissions{get; set;}
 public List<User_Profile_Event__c> listOfEvents { get; set; }
 public Event__c EventDetail{get; set;}
 public string SelectedEventId {get;set;}
  
 public MM_eventsCon(){
    listOfEvents = new List<User_Profile_Event__c>(); 
    
    listOfEvents =[select u.EV_id__r.Status__c,u.EV_id__r.StartTime__c, u.EV_id__r.SecondaryCategory__c,
    u.EV_id__r.Primary__c, u.EV_id__r.Name, u.EV_id__r.Id, u.EV_id__r.EV_Title__c, u.EV_id__r.EV_StartDate__c, u.EV_id__r.EV_HostingZipcode__c, 
    u.EV_id__r.EV_HostingTimeZone__c, u.EV_id__r.EV_HostingState__c,u.EV_id__r.EV_HostingPostalCode__c,
    u.EV_id__r.EV_HostingPhone__c, u.EV_id__r.EV_HostingLocation__c, u.EV_id__r.EV_HostingCountry__c,
    u.EV_id__r.EV_HostedByEventBrite__c, u.EV_id__r.EV_HistingAddr1__c, u.EV_id__r.EV_EventLogo__c,u.EV_id__r.CCRDetails_Required__c, 
    u.EV_id__r.EV_EndTime__c,u.EV_id__r.EV_EndDate__c, u.EV_id__r.EV_Description__c, u.Profile_id__r.PR_Name__c,
    u.EV_id__r.CreatedDate, u.EV_id__r.Attendee_Tags__c,u.EV_id__r.EV_HostingOrgName__c, u.EV_id__r.AS_HostingCity__c,u.EV_id__r.AS_HostingAddr2__c from User_Profile_Event__c u 
    where u.IsMatchMakingUser__c=true AND u.User_id__r.userName=:UserInfo.getUserName() ORDER BY createdDate DESC];
      
    
    changeEvent();
 }    
      
      
      
    public PageReference changeEvent() {
    
     SelectedEventId = ApexPages.currentpage().getparameters().get('eventName');
        
       if( SelectedEventId==null ||  SelectedEventId==''){
         if(listOfEvents.size()>0){
           SelectedEventId=listOfEvents[0].EV_id__c;
         }     
      
       }
        
        
        if(SelectedEventId != NULL)
        {
              
        EventDetail = [SELECT ID, Name,EV_Title__c,Status__c,EV_HostingState__c,AS_HostingCity__c,EV_HostingLocation__c,Attendee_Types__c,
                    EV_HistingAddr1__c,AS_HostingAddr2__c,EV_HostingCountryNew__c,EV_Publish__c,EV_EventLogo__c,EV_HostingTimeZone__c,
                    EV_HostingPhone__c,EV_HostingFax__c,EV_WebsiteURL__c,Primary__c,SecondaryCategory__c,EV_HostingOrgName__c,EV_HostingStateNew__c,
                    EV_HostingZipcode__c,EV_HostingPostalCode__c,EV_HostedByEventBrite__c,EV_Description__c,Owner.FirstName,Owner.ID,
                    EV_EndTime__c, StartTime__c, EV_EndDate__c, EV_StartDate__c,EventDiversityValues__c,TwitterHashTag__c,
                    Lable_First_Line__c,Lable_Secoend_Line__c,Lable_Third_Line__c,Event_Printer__c,
                    Lable_First_Line_Color__c,Lable_First_Line_Size__c,Lable_First_Line_Font__c,Lable_Secoend_Line_Color__c,Lable_Secoend_Line_Size__c,Lable_Secoend_Line_Font__c,
                    Lable_Third_Line_Color__c,Lable_Third_Line_Size__c,EV_SiteLocation__c,Lable_Third_Line_Font__c FROM Event__C WHERE id =:SelectedEventId ];
        }
        
        LIST<User_Profile_Event__c> upeList = New LIST<User_Profile_Event__c>();
        
        upeList = [SELECT ID, NAME, Profile_id__r.PR_Name__c, Profile_id__c,MAtchMakingProfile__c FROM User_Profile_Event__c WHERE EV_id__c =: SelectedEventId AND IsMatchMakingUser__c=true AND User_id__r.userName=:UserInfo.getUserName()  ];
     try{   
         boothAdminBool = FALSE;
         AttendeeBoolean = FALSE;
         
        if(upeList.size() >=1){
            if(upeList[0].Profile_id__c != null){
               if(upeList[0].MAtchMakingProfile__c == 'Corporate')
                    boothAdminBool = TRUE;
               else If( upeList[0].MAtchMakingProfile__c == 'MBE')
                   AttendeeBoolean = TRUE;
                    
            }
        }
      }catch(Exception e){   
           AttendeeBoolean = TRUE;
      }  
      
      
      system.debug('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'+ boothAdminBool +'    '+AttendeeBoolean );
      
        return null;
        
    }
    
    public Boolean boothAdminBool{get; set;}
    public Boolean AttendeeBoolean{get;set;}
    
    public void CheckEvents(){
    
        system.debug('    FFFFFFFFFFFFFFFFFFF   '+ listOfEvents );
        
    }
    
    
    
    
}