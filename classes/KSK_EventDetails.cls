@RestResource(urlMapping='/KSK_EventDetails/*')

/**
 * AUTHOR: Rajesh
 * AIM   : This service is developed to validate request from KIOSK Application
 */
global without Sharing class KSK_EventDetails{

@httpPost
global static AllDetails doPost(){

     RestRequest req = RestContext.request;
     RestResponse res = RestContext.response;
     string eveid;
     
     eveid = req.params.get('eveid');
     system.debug('eveid ===  '+eveid );
     AllDetails alDetail = new AllDetails();
     
    if(eveid == NULL || eveid == '' ){
      GlobalUtillClass.KSKEventDetails Guser45 = new GlobalUtillClass.KSKEventDetails('Please check the Event Id');
         alDetail.EventsDetails.add(Guser45);
         return alDetail;
     }
   
   try{
   Event__c ev = [Select e.EV_HostingZipcode__c,e.Status__c,  e.EV_WebsiteURL__c, e.EV_Title__c, 
                  e.EV_StartDate__c, e.EV_SiteLocation__c,e.StartTime__c, e.EV_HostingStateNew__c, e.EV_HostingPhone__c, 
                  e.EV_HostingOrgName__c, e.EV_HostingLocation__c, e.EV_HostingCountryNew__c, e.EV_HistingAddr1__c, 
                  e.EV_EventLogo__c, e.EV_EndTime__c, e.EV_EndDate__c, e.EV_Description__c, e.AS_HostingCity__c, 
                  e.TwitterHashTag__c, e.AS_HostingAddr2__c, e.Floor_Map_Image__c From Event__c e where Id =: eveid ];
      
      if(ev.Floor_Map_Image__c != '' || ev.Floor_Map_Image__c != NULL){
          GlobalUtillClass.KSKEventModules fmp = new GlobalUtillClass.KSKEventModules('FloorMap'); 
          alDetail.EventModules.add(fmp);
      }
      
      
      if(ev!=NULL){
         GlobalUtillClass.KSKEventDetails Gevents = new GlobalUtillClass.KSKEventDetails(ev); 
         alDetail.EventsDetails.add(Gevents);
      }else{
      
         GlobalUtillClass.KSKEventDetails Guser45 = new GlobalUtillClass.KSKEventDetails('Please check the Event Id sent, we did no find any event with this Id');
         alDetail.EventsDetails.add(Guser45);
      }
      }catch(Exception e){
          GlobalUtillClass.KSKEventDetails Guser45 = new GlobalUtillClass.KSKEventDetails('Please check the Event Id sent, we did no find any event with this Id');
          alDetail.EventsDetails.add(Guser45);
      }
      
     // LIST<Floor_Map__c> fmp = new LIST<Floor_Map__c>();
      for(Floor_Map__c fmp : [SELECT Id, Name, Parameters__c, Type__c, Booth_Area__c FROM Floor_Map__c WHERE Event__c =: eveid AND Type__c = 'Kiosk'  ]){
           GlobalUtillClass.KSKKiosksList kls = new GlobalUtillClass.KSKKiosksList(fmp); 
           alDetail.KiosksList.add(kls);
      }
      
      //try{
           LIST<User_Profile_Event__c> exhs =new LIST<User_Profile_Event__c>();
           exhs = [SELECT Id FROM User_Profile_Event__c WHERE EV_id__r.Id =: eveid AND Profile_id__r.PR_Name__c = 'BoothAdmin'];
           if(exhs.size()>0){
               GlobalUtillClass.KSKEventModules evexhs = new GlobalUtillClass.KSKEventModules('Exhibitors'); 
               alDetail.EventModules.add(evexhs);
           }
           
           LIST<EventSchedule__c> evs =new LIST<EventSchedule__c>();
           evs = [SELECT Id FROM EventSchedule__c WHERE EV_id__r.Id =: eveid];
           if(evs.size()>0){
               GlobalUtillClass.KSKEventModules evsc = new GlobalUtillClass.KSKEventModules('Schedules'); 
               alDetail.EventModules.add(evsc);
           }
           
           LIST<Seminar__c> sems =new LIST<Seminar__c>();
           sems = [SELECT Id FROM Seminar__c WHERE Track__r.Event__r.Id =: eveid];
           if(sems.size()>0){
               GlobalUtillClass.KSKEventModules semns = new GlobalUtillClass.KSKEventModules('Keynotes'); 
               alDetail.EventModules.add(semns);
           }
           
      //}catch(Exception evscs){ }
    
    
    
    
    
   return alDetail;
}


global class AllDetails{
List<GlobalUtillClass.KSKEventDetails> EventsDetails = new List<GlobalUtillClass.KSKEventDetails>();
List<GlobalUtillClass.KSKEventModules> EventModules = new List<GlobalUtillClass.KSKEventModules>();
List<GlobalUtillClass.KSKKiosksList> KiosksList = new List<GlobalUtillClass.KSKKiosksList>();
}



}