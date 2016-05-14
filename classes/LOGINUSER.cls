@RestResource(urlMapping='/LoginUser/*')

/**
 * AUTHOR: Phani
 * Email : phani@globalnest.com
 * Phone : 9550710718
 * AIM   : To insert attendee
 */
global without Sharing class LOGINUSER{

 @httpPost
 global static AllDetails doPost(){

     RestRequest req = RestContext.request;
     RestResponse res = RestContext.response;
     string userName;
     string passWord;
     userName =req.params.get('userName').tolowercase();
     passWord = req.params.get('passWord');
          AllDetails alDetail = new AllDetails();
            GlobalUtillClass g=new GlobalUtillClass();
  try{alDetail.AttendeeCountries=g.getDependentOptionsImpl('AttendeeSummary__c','AS_Work_Country__c','AS_Work_States__c');}catch(Exception e){}
     List<user> users = new List<user>();
    // AttendeeSummary__c AttendeeId = new AttendeeSummary__c();
     users = [select Username,firstName,LastName,Email,Phone,CompanyName,states__c,Country__c,City,title,profile.Name,password__c,isSignup__c from user where userName=:userName ];
     //AttendeeId=[select id from AttendeeSummary__c where AS_Email__c =: users.userName];
     if(users.size()<=0){
     // Please dont not remove true this is for navigation in mobile
      GlobalUtillClass.UserDetails Guser45 = new GlobalUtillClass.UserDetails('You did not sign up for Booth Leads, Please click on Sign Up &, true');
      alDetail.userProfile.add(Guser45);
      return alDetail;
    }else{
    
      if(users[0].profile.Name=='Event Admin'){
            GlobalUtillClass.UserDetails Guser45 = new GlobalUtillClass.UserDetails('Event organizer can not access this app');
            alDetail.userProfile.add(Guser45);
           return alDetail;
        }else{
           if(passWord != users[0].password__c){
               GlobalUtillClass.UserDetails Guser45 = new GlobalUtillClass.UserDetails('Invalid credentials');
               alDetail.userProfile.add(Guser45);
              return alDetail;
           }
        
        }
        
       if(!users[0].isSignup__c){
             GlobalUtillClass.UserDetails Guser45 = new GlobalUtillClass.UserDetails('You did not sign up for Booth Leads, Please click on Sign Up &, true');
             alDetail.userProfile.add(Guser45);
             return alDetail;
          }
      
    }    
    
    
     List<AttendeeSummary__c> att =new List<AttendeeSummary__c>();
     att = [select id,AS_ImageUrl__c,AS_Email__c,AS_Title__c from AttendeeSummary__c where AS_Email__c=:userName];
     string imgurl;
     
     if(att.size()>0){
       imgurl =att[0].AS_ImageUrl__c;
       }
     
    string attvalues='';
     List<Id> listOfEvents = new List<Id>();
     
     for(user Us :users ){
  //  GlobalUtillClass.UserDetails Guser = new GlobalUtillClass.UserDetails(Us,att);
      if(att.size()>0){
      try{
         Us.title = att[0].AS_Title__c;
         }catch(exception e){}
      }
    GlobalUtillClass.UserDetails Guser = new GlobalUtillClass.UserDetails(Us,imgurl,attvalues);
     alDetail.userProfile.add(Guser);
     }

 
      for(User_Profile_Event__c upes:[Select u.User_id__c, u.Profile_id__c, u.EV_id__c,EV_id__r.owner.name,EV_id__r.Enable_Scan_To_ATT__c,EV_id__r.Enable_Scan_To_BA__c From User_Profile_Event__c u where User_id__r.userName=:userName  and ((EV_id__r.Enable_Scan_To_ATT__c=TRUE and Profile_id__r.PR_Name__c='Attendee') OR (EV_id__r.Enable_Scan_To_BA__c=TRUE and (Profile_id__r.PR_Name__c='BoothAdmin' OR Profile_id__r.PR_Name__c='BoothPersonnel')))]){
        listOfEvents.add(upes.EV_id__c);
        
     } 
   
   
   //((EV_id__r.Owner.Name='Mark Neuwirt' and Profile_id__r.PR_Name__c!='Attendee') OR (EV_id__r.owner.Name!='Mark Neuwirt'))
   
    for(Event__c ev:[Select e.EV_HostingZipcode__c,e.Status__c,  e.EV_WebsiteURL__c, e.EV_Title__c, e.EV_StartDate__c, e.EV_SiteLocation__c,e.StartTime__c, e.EV_HostingStateNew__c, e.EV_HostingPhone__c, e.EV_HostingOrgName__c, e.EV_HostingLocation__c, e.EV_HostingCountryNew__c, e.EV_HistingAddr1__c, e.EV_EventLogo__c, e.EV_EndTime__c, e.EV_EndDate__c, e.EV_Description__c, e.AS_HostingCity__c, e.TwitterHashTag__c, e.AS_HostingAddr2__c From Event__c e where Id In :listOfEvents ]){
     GlobalUtillClass.EventDetails Gevents = new GlobalUtillClass.EventDetails(ev); 
     alDetail.eventDetails.add(Gevents);
    }
    
  /**  for(EventSchedule__c eveSc :[Select e.Name, e.Id, e.EV_id__c,e.EV_id__r.EV_Title__c, e.ES_StartTime__c, e.ES_StartDate__c, e.ES_ProgramName__c, e.ES_Presenter__c, e.ES_Location__c, e.ES_EndTime__c, e.ES_EndDate__c, e.ES_Description__c From EventSchedule__c e where EV_id__c IN :listOfEvents limit 20]){
     GlobalUtillClass.EventSchedule Geventscdules = new GlobalUtillClass.EventSchedule(eveSc);  
     alDetail.EventSchedule.add(Geventscdules);
    }
    
    
    for(Booth__c booths :[Select id,BT_Name__c,BT_Description__c,BT_ContactName__c,BT_ContactEmail__c,BT_ContactPhone__c,BT_WebsiteURL__c,BT_Location__c, BT_PDFLocation__c,BT_RegistrationLink__c,BT_Phone__c,EV_id__c,EV_id__r.EV_Title__c from Booth__c where EV_id__c IN :listOfEvents limit 20]){
     GlobalUtillClass.BoothDetails Gbooths = new GlobalUtillClass.BoothDetails(booths); 
     alDetail.Exhibitors.add(Gbooths);
     
    }
    **/
    
    Set<id> bvsids = new Set<id>();
    for(User_Event_BVS__c bvslist:[Select Id,BVS_id__r.id,EV_id__c,   UPE_id__c,UPE_id__r.User_id__r.userName  from User_Event_BVS__c where  UPE_id__r.User_id__r.userName=:userName]){
      bvsids.add(bvslist.BVS_id__r.id); 
    }
    
    
    
    
    for(BoothVisitSummary__c leadsval :[Select   b.User_id__c, b.ScannedTime__c, b.ScanTime__c, b.OwnerId,
   b.Name, b.Mrecordid__c, b.LastModifiedDate, b.LastModifiedById, b.LastActivityDate, b.IsDeleted, b.ImageData__c,
   b.Id, b.Follow_Update__c, b.EA_AttendeeBarcode__c, b.Dummy__c, b.CreatedDate, 
    b.BVS_Title__c, b.BVS_Tags__c, b.BVS_SurveyQuestion4__c, b.BVS_SurveyQuestion3__c,SalesForceStatus__c,
   b.BVS_SurveyQuestion2__c, b.BVS_SurveyQuestion1__c, b.BVS_SurveyAnswer4__c, b.BVS_SurveyAnswer3__c, b.BVS_SurveyAnswer2__c,
   b.BVS_SurveyAnswer1__c, b.BVS_State__c, b.BVS_PhoneNumber__c, b.BVS_Notes__c, b.BVS_LeadType__c, b.BVS_LeadRating__c,
   b.BVS_LeadCategory__c, b.BVS_LastName__c, b.BVS_FollowUps__c, b.BVS_FirstName__c, b.BVS_Email__c, b.BVS_Company__c,
   b.BVS_City__c, b.BVS_Budget__c, b.AttachmentId__c,EA_AttendeeBarcode__r.UniqNo__c, b.AS_ImageUrl__c,EA_AttendeeBarcode__r.EV_id__c,EA_AttendeeBarcode__r.EV_id__r.EV_Title__c From BoothVisitSummary__c b where Id IN :bvsids and EA_AttendeeBarcode__c!=null order by createdDate limit 20]){
   
   GlobalUtillClass.Leads Gleads = new GlobalUtillClass.Leads(leadsval);    
   alDetail.leads.add(Gleads);
   }
   
    if((alDetail.leads).size()>0){
    integer sizeOfleads =(alDetail.leads).size()-1;   
    alDetail.lastRecordId =alDetail.leads[sizeOfleads].recordId;
     system.debug('5555555333333333'+alDetail.lastRecordId);
    }
   
   
    system.debug('1111111111111111111 '+alDetail.leads);
    
    
   return alDetail;
}


global class AllDetails{
string lastRecordId ;
List<GlobalUtillClass.UserDetails> userProfile = new List<GlobalUtillClass.UserDetails>();
List<GlobalUtillClass.EventDetails> eventDetails = new List<GlobalUtillClass.EventDetails>();
List<GlobalUtillClass.EventSchedule> EventSchedule = new List<GlobalUtillClass.EventSchedule>();
List<GlobalUtillClass.BoothDetails> Exhibitors = new List<GlobalUtillClass.BoothDetails>();
List<GlobalUtillClass.leads> Leads = new List<GlobalUtillClass.leads>();
list <GlobalUtillClass.Countries> AttendeeCountries= new List<GlobalUtillClass.Countries>();

}



}