@RestResource(urlMapping='/KSK_LoginUser/*')

/**
 * AUTHOR: Rajesh
 * AIM   : This service is developed to validate request from KIOSK Application
 */
global without Sharing class KSK_LoginUser{

@httpPost
global static AllDetails doPost(){

     RestRequest req = RestContext.request;
     RestResponse res = RestContext.response;
     string userName;
     string passWord;
     userName =req.params.get('userName').tolowercase();
     passWord = req.params.get('passWord');
     system.debug('userName=== '+userName+'   passWord====  '+passWord);
     AllDetails alDetail = new AllDetails();
     List<user> users = new List<user>();
     
     users = [select Username,firstName,LastName,Email,Phone,CompanyName,states__c,Country__c,City,Title from user where userName=:userName and password__c=:passWord and profile.Name='Event Admin'];
     
     if(users.size()<=0){
         GlobalUtillClass.UserDetails Guser45 = new GlobalUtillClass.UserDetails('Invalid credentials');
         alDetail.EventAdminDetails.add(Guser45);
         return alDetail;
     }    
    
    
     List<AttendeeSummary__c> att =new List<AttendeeSummary__c>();
     att = [select id,AS_ImageUrl__c,AS_Email__c from AttendeeSummary__c where AS_Email__c=:userName];
     string imgurl;
     
     if(att.size()>0){
       imgurl =att[0].AS_ImageUrl__c;
       }
     
    string attvalues='';
     List<Id> listOfEvents = new List<Id>();    
     
     for(user Us :users ){  
         GlobalUtillClass.UserDetails Guser = new GlobalUtillClass.UserDetails(Us,imgurl,attvalues);
         alDetail.EventAdminDetails.add(Guser);
     }

 
      for(User_Profile_Event__c upes:[Select u.User_id__c, u.Profile_id__c, u.EV_id__c,EV_id__r.owner.name,EV_id__r.Enable_Scan_To_ATT__c,EV_id__r.Enable_Scan_To_BA__c From User_Profile_Event__c u where User_id__r.userName=:userName and User_id__r.Profile.Name='Event Admin']){  /* ((EV_id__r.Enable_Scan_To_ATT__c=TRUE and Profile_id__r.PR_Name__c='Attendee') OR (EV_id__r.Enable_Scan_To_BA__c=TRUE and (Profile_id__r.PR_Name__c='BoothAdmin' OR Profile_id__r.PR_Name__c='BoothPersonnel')) */
        listOfEvents.add(upes.EV_id__c);
     } 
   
   if(listOfEvents.size()>0){
       for(Event__c ev:[Select e.EV_HostingZipcode__c,e.Status__c,  e.EV_WebsiteURL__c, e.EV_Title__c, e.EV_StartDate__c, e.EV_SiteLocation__c,e.StartTime__c, e.EV_HostingStateNew__c, e.EV_HostingPhone__c, e.EV_HostingOrgName__c, e.EV_HostingLocation__c, e.EV_HostingCountryNew__c, e.EV_HistingAddr1__c, e.EV_EventLogo__c, e.EV_EndTime__c, e.EV_EndDate__c, e.EV_Description__c, e.AS_HostingCity__c, e.TwitterHashTag__c, e.AS_HostingAddr2__c From Event__c e where Id In :listOfEvents ]){
       GlobalUtillClass.KSKEventList Gevents = new GlobalUtillClass.KSKEventList(ev); 
       alDetail.EventsList.add(Gevents);
        }
    
    }else{
         GlobalUtillClass.KSKEventList Guser45 = new GlobalUtillClass.KSKEventList('No Events found');
         alDetail.EventsList.add(Guser45);
   }
    
   return alDetail;
}


global class AllDetails{
List<GlobalUtillClass.UserDetails> EventAdminDetails = new List<GlobalUtillClass.UserDetails>();
List<GlobalUtillClass.KSKEventList> EventsList = new List<GlobalUtillClass.KSKEventList>();
}



}