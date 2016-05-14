@RestResource(urlMapping='/getLiveEvents/*')

 global without sharing class getLiveEvents{
 
  
  @HttpGet
  global static AllDetails doGet(){
  
  RestRequest req = RestContext.request;
  RestResponse res = RestContext.response;
  
  string UserName =   req.params.get('UserName');
  string PassWord =   req.params.get('PassWord');
  
  List<user> usersEventadmin =new List<user>();
  usersEventadmin =[select id,userName from user Where userName=:UserName and password__c=:PassWord and profile.Name='Event admin'];
        
   AllDetails alDetail = new AllDetails();
      
   if(usersEventadmin.size()>0){
    List<id> listEventIds = new List<id>();
    Profile__c pro =[select id from Profile__c where PR_Name__c='EventAdmin'];
   
    for(User_Profile_Event__c upe : [select EV_id__c,EV_id__r.id from User_Profile_Event__c where User_id__c=:usersEventadmin[0].id and Profile_id__c=:pro.id]){
    listEventIds.add(upe.EV_id__r.id);
    }
   
    for(Event__c ev:[Select e.EV_HostingZipcode__c,e.Status__c,  e.EV_WebsiteURL__c, e.EV_Title__c, e.EV_StartDate__c, e.EV_SiteLocation__c,e.StartTime__c, e.EV_HostingStateNew__c, e.EV_HostingPhone__c, e.EV_HostingOrgName__c, e.EV_HostingLocation__c, e.EV_HostingCountryNew__c, e.EV_HistingAddr1__c, e.EV_EventLogo__c, e.EV_EndTime__c, e.EV_EndDate__c, e.EV_Description__c, e.AS_HostingCity__c, e.AS_HostingAddr2__c,TwitterHashTag__c  From Event__c e where id IN :listEventIds]){
     GlobalUtillClass.EventDetails Gevents = new GlobalUtillClass.EventDetails(ev); 
    
     alDetail.eventDetails.add(Gevents);
    }
    
    if(alDetail.eventDetails.size()<=0){
     alDetail=new AllDetails('No Events found');
    }
   system.debug('22222222222 '+alDetail.eventDetails.size());
  }else{
   alDetail=new AllDetails('Invalid credentials');
  }
  
  
  return alDetail;
 }
 
 
 
 
 
global class AllDetails{
public string error{get;set;}
List<GlobalUtillClass.EventDetails> eventDetails = new List<GlobalUtillClass.EventDetails>();
public AllDetails(string era){
this.error=era;
}

public AllDetails(){

}

}

}